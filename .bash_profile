source /usr/local/git/contrib/completion/git-completion.bash

export HISTCONTROL=erasedups
export HISTSIZE=1000
export PATH=/Applications/ColdFusion10/cfusion/bin:$HOME/.cabal/bin:$PATH
export PS1='[\u@\h \W]$ '
export HOMEBREW_GITHUB_API_TOKEN=5e273d2c237e553d8ede97236a9a69954ce00110
export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man
export VIMCLOJURE_SERVER_JAR="$HOME/lib/vimclojure/server-2.3.6.jar"

#------------------------------------------------------------------------------
# Bash options
#------------------------------------------------------------------------------
shopt -s cdable_vars
shopt -s cdspell
shopt -s cmdhist
shopt -s histappend
shopt -s nocaseglob

set -o vi

#------------------------------------------------------------------------------
# Custom aliases
#------------------------------------------------------------------------------
alias bc='bc -l'
alias date='date +"%A, %B %d, %Y - %r"'
alias grep='grep -ri'
alias grepl='grep -ril'
alias h='history'
alias ls='/usr/local/bin/ls -h --color'
alias ll='/usr/local/bin/ls -lv --group-directories-first'
alias more='less'
alias prolog='swipl'
alias rmparse='rm -f ~/Sites/freepeople/fusebox/public/parsed/* && rm -f ~/Sites/freepeople/fusebox/htdocs/admin/parsed/*'

alias cf='cd /Applications/ColdFusion10/cfusion/bin'
alias db='cd ~/Dropbox'
alias fp='cd ~/Sites/freepeople'
alias hd='cd ~/Sites/hd'
alias sstack='cd ~/Sites/sstack'
alias tomcavage='cd ~/Sites/tomcavage'
alias wa='cd ~/Sites/workarea'

alias buildqa='cd ~/Sites/freepeople && ruby scripts/run_build.rb -e QA -p "FREEPEOPLE"'
alias buildstage='cd ~/Sites/freepeople && ruby scripts/run_build.rb -e Staging -p "FREEPEOPLE"'

alias ga='echo git add && git add'
alias gb='echo git branch && git branch'
alias gc='echo git checkout && git checkout'
alias gd='echo git diff && git diff'
alias gf='echo git fetch && git fetch'
alias gk='open /Applications/Tower.app'
alias gco='echo git commit -m && git commit -m'
alias gpop='git stash pop'
alias gpush='git stash'
alias gs='echo git status && git status'

alias tomcavage='ssh stomcavage@96.126.107.61'

#------------------------------------------------------------------------------
# Color definitions
#------------------------------------------------------------------------------

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

#------------------------------------------------------------------------------
# Custom functions
#------------------------------------------------------------------------------
function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=45
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function _prompt_command() {
    PS1="`_git_prompt`"'[\[\e[1;34m\]\u@\h \W\[\e[0m\]]$ '
}

PROMPT_COMMAND=_prompt_command

function cfrestart() {
	sudo coldfusion restart
	sudo apachectl restart
}

function cfstop() {
	sudo coldfusion stop
}

function cfstart() {
	sudo coldfusion start
}

function cfstatus() {
	sudo coldfusion status
}

function fprestart() {
	sudo rm -f /Users/stomcavage/Sites/freepeople/fusebox/public/parsed/*
	sudo rm -f /Users/stomcavage/Sites/freepeople/htdocs/admin/parsed/*
	sudo coldfusion restart
	sudo apachectl restart
}

function routefp() {
	# If ppp0 is device connected to WebLinc VPN, this sets up access to IP-restricted FP sites
	sudo route add -net 198.135.29.42/8 -interface ppp0

}

function gbc() {
    gb $1 && gc $1
}

export PATH="$HOME/.rbenv/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
