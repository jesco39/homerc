# Set colorful PS1 only on colorful terminals.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
    fi

    alias ls="ls -G"
    alias grep="grep -G"
else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

# Try to keep environment pollution down, EPA loves us.
unset safe_term match_lhs

# User specific environment and startup programs
export HISTCONTROL=ignoreboth
export EDITOR=/usr/bin/vim

# Alias file
 if [[ -f ~/.aliasrc ]]; then
                source ~/.aliasrc
 fi

# Time format
export TIMEFORMAT='r: %R, u: %U, s: %S'

# mkdir, cd into it
mkcd () {
        mkdir -p "$*"
        cd "$*"
}

# Wiki using dig
function wiki () {
        COLUMNS=`tput cols`
        dig +short txt ${1}.wp.dg.cx | sed -e 's/" "//g' -e 's/^"//g' -e 's/"$//g' -e 's/ http:/\n\nhttp:/' | fmt -w $COLUMNS
}

# Google my noodle in bash
function google () {
        query=""
        for this_query_term in $@
        do
                query="${query}${this_query_term}+"
        done
        url="http://www.google.com/search?q=${query}"

        remote_addr=`who am i | awk -F\( '{print $2}' | sed 's/)//'`

        if [ -z "$remote_addr" ]; then
          open "$url"
        else
          links "$url"
        fi
}

# Set custom bashrc for known systems
case $HOSTNAME in
  jesco.local)
    if [[ -f ~/.bashrc-mac ]]; then
	  source ~/.bashrc-mac
	fi
  ;;
  modamac.local)
    if [[ -f ~/.bashrc-mac ]]; then
	  source ~/.bashrc-mac
	fi
  ;;
  moda)
    if [[ -f ~/.bashrc-linux ]]; then
	  source ~/.bashrc-linux
	fi
  ;;
esac
