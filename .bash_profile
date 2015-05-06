if [ -f ${HOME}/.bashrc ]; then source ${HOME}/.bashrc; fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]
then
    source /usr/local/git/contrib/completion/git-completion.bash
else
    echo WARNING: Unable to find git-completion.bash
fi

#------------------------------------------------------------------------------
# Environment variables
#------------------------------------------------------------------------------
export CFLAGS='-g -Wall -O3'
export EDITOR=`which vim`
export HISTCONTROL=erasedups
export HISTSIZE=1000
export PATH=$HOME/yesod-bin-sandbox/.cabal-sandbox/bin:.cabal-sandbox/bin:$HOME/.cabal/bin:$HOME/bin:$PATH
export PS1='[\u@\h \W]$ '
export HOMEBREW_GITHUB_API_TOKEN=5e273d2c237e553d8ede97236a9a69954ce00110
export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man
export VIMCLOJURE_SERVER_JAR="$HOME/lib/vimclojure/server-2.3.6.jar"

#------------------------------------------------------------------------------
# Custom aliases
#------------------------------------------------------------------------------
alias bc='bc -l'
alias date='date +"%A, %B %d, %Y - %r"'
alias grep='grep -ri'
alias grepl='grep -ril'
alias h='history'
alias ls='ls -h --color'
alias ll='ls -lv --group-directories-first'
alias more='less'
alias prolog='swipl'

alias ga='echo git add && git add'
alias gb='echo git branch && git branch'
alias gc='echo git checkout && git checkout'
alias gd='echo git diff && git diff'
alias gf='echo git fetch origin && git fetch origin'
alias gk='open /Applications/Tower.app'
alias gco='echo git commit -m && git commit -m'
alias gpop='git stash pop'
alias gpush='git stash'
alias gs='echo git status && git status'

if [ -f ${HOME}/my_aliases.bash ]; then source ${HOME}/my_aliases.bash; fi

#------------------------------------------------------------------------------
# Custom functions
#------------------------------------------------------------------------------
function _git_prompt(){
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

function gbc(){
    gb $1 && gc $1
}

function gp(){
    echo git pull origin $1 && git pull origin $1
}

function _prompt_command(){
    PS1="`_git_prompt`"'[\[\e[1;34m\]\u@\h \W\[\e[0m\]]$ '
}

PROMPT_COMMAND=_prompt_command

#------------------------------------------------------------------------------
# Enable switching between elasticsearch 1.4 and 0.9 
#------------------------------------------------------------------------------
function use_ec09(){
    launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist;
    sudo rm -rf /usr/local/var/elasticsearch/elasticsearch_$(whoami)/nodes/0/indices;
    brew unlink elasticsearch090 && brew link --overwrite elasticsearch090;
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch090.plist;
}

function use_ec14(){
    launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch090.plist;
    brew unlink elasticsearch && brew link --overwrite elasticsearch;
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist;
}

function which_ec(){
    curl localhost:9200;
}

#------------------------------------------------------------------------------
# Enable rbenv to be able to switch Ruby versions
#------------------------------------------------------------------------------
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

