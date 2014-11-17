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
	sudo route add -net 198.135.29.42/8 -interface ppp0
}

function gbc() {
    gb $1 && gc $1
}

export PATH="$HOME/.rbenv/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"