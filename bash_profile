# aliases
alias l1="ls -ogh"
alias log="git log --no-merges --name-only"
alias untar="tar -xzvf"
alias rmdir="rm -rf"
alias cpdir="cp -r"
alias psg="ps aux | grep"

# TODO: create Apps folder
# TODO: instalar y preparar shelr 
# https://github.com/shelr/shelr
# Perm'ing your key: TODO, make it werk.
# ssh-add
# exec ssh-agent bash

# Z: z is the new j, yo.
if [ ! -d ~/Apps/z/ ]; then
  cd ~/Apps && git clone git://github.com/rupa/z.git && cd -
fi
. ~/Apps/z/z.sh

# If git vundle doesn't exist, clone it.
if [ ! -d ~/.vim/bundle/vundle ]; then
  cd ~/ && git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 
fi

# Git completion bash script
if [ ! -f ~/.git-completion.sh ]; then
  cd ~/ && wget -O .git-completion.sh --no-check-certificate https://raw.github.com/git/git/master/contrib/completion/git-completion.bash 
fi
. ~/.git-completion.sh

# exports
export EDITOR='vim'
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

# otras monerias
bind 'set completion-ignore-case on'
shopt -s histappend
shopt -s checkwinsize

# Ubuntu only 
if [[ `hostname -s` == "leopic-Latitude-E6520" ]]; then
  alias ls="ls --color"
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_32"
  export JAVA_HOME="/usr/lib/jvm/jdk1.6.0_32"
  PATH=$HOME/Apps/Sublime\ Text\ 2/:"$PATH"
  PATH=$HOME/Apps/WebStorm-121.390/bin/:"$PATH"

  alias apre="sudo /etc/init.d/apache2 restart"
  alias aplog="tail -f /var/log/apache2/error.log"
  alias ij="/home/leopic/Apps/idea-IU-95.627/bin/./idea.sh"
  alias l2="ls -1Fsh --group-directories-first"
  alias open="xdg-open"
  alias myip="ifconfig | grep 'inet addr:' | head -1"
  alias sath="cd /var/www/athlete/src; export USE_MYSQL=1; python manage.py runserver; cd -;"
fi

# CentOS only
if [[ `hostname -s` == "lpicado-atg-dev" ]]; then
  alias ls="ls --color"
  PATH=$PATH:$HOME/bin:$HOME/atgScripts
  alias katg="$HOME/atgScripts/atg kill-all"
  alias ratg="$HOME/atgScripts/atg restart public"
  alias satg="$HOME/atgScripts/atg start public"
  alias anta="cd $HOME/workspaces/atg-backcountry-ca/modules/; ant all; cd -;"
  alias antd="cd $HOME/workspaces/atg-backcountry-ca/modules/; ant update-data; cd -;"
  alias antf="cd $HOME/workspaces/atg-backcountry-ca/modules/; ant full; cd -;"
  alias df="git diff develop | pastebin -f diff -a leopic"
  # avoiding branching gitconfig
  cd ~/workspaces/atg-backcountry-ca/ && git config user.name "Leo Picado" && git config user.email "lpicado@backcountry.com"
fi


# branch in prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)➔ '

# adding git branch to prompt in DH
if [[ `hostname -s` == "suhail" ]]; then
  alias ls="ls --color"
fi

# adding git branch to prompt in DH/Mac
if [[ `hostname -s` == "lpicados-mbp" ]] || [[ `hostname -s` == "suhail" ]]; then
  __git_ps1 () 
  { 
      local b="$(git symbolic-ref HEAD 2>/dev/null)";
      if [ -n "$b" ]; then
          printf " (%s)" "${b##refs/heads/}";
      fi
  }
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '
fi

# dandole color a los ls en mac
if [[ `hostname -s` == "lpicados-mbp" ]]; then
  alias ls="ls -G"
  export LSCOLORS=dxfxcxdxbxegedabagacad
fi

# Handy to have
# key is corrupt, permissions to open
alias fixkey="sudo chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub"

