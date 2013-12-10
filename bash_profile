# aliases
alias l1="ls -ogh"
alias log="git log --no-merges --name-only"
alias untar="tar -xzvf"
alias rmdir="rm -rf"
alias cpdir="cp -r"
alias psg="ps aux | grep"
alias p2p="git pull origin develop && git checkout develop && git pull"

# TODO: create Apps folder
# TODO: instalar y preparar shelr 
# https://github.com/shelr/shelr
# Perm'ing your key: TODO, make it werk.
# ssh-add
# exec ssh-agent bash

# Z: z is the new j, yo.
if [ ! -d ~/Apps/ ]; then
  cd ~/ && mkdir Apps && cd -
fi

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
  # Agregando variable Android SDK
  export ANDROID_SDK="/home/leopic/Apps/adt-bundle-linux-x86_64-20130729"
  # Agregando Android SDK al Path
  PATH=$HOME/Apps/WebStorm-129.664/bin/:"$PATH"
  PATH=/home/leopic/Apps/adt-bundle-linux-x86_64-20130729/sdk/platform-tools:"$PATH"
  PATH=/home/leopic/Apps/adt-bundle-linux-x86_64-20130729/sdk/tools:"$PATH"
  complete -W "$(teamocil --list)" teamocil

  alias apre="sudo /etc/init.d/apache2 restart"
  alias aplog="tail -f /var/log/apache2/error.log"
  alias ij="/home/leopic/Apps/idea-IU-95.627/bin/./idea.sh"
  alias tis="/home/leopic/Apps/Titanium_Studio/TitaniumStudio"
  alias titanium.py=$HOME/.titanium/mobilesdk/linux/3.1.2.GA/titanium.py
  alias l2="ls -1Fsh --group-directories-first"
  alias open="xdg-open"
  alias myip="ifconfig | grep 'inet addr:' | head -1"
  alias sath="cd /var/www/athlete/src; export USE_MYSQL=1; sudo pip install -r ../requirements/global.txt; sudo pip install -r ../requirements/dev.txt; python manage.py syncdb; python manage.py migrate; python manage.py runserver;"
  alias tmath="teamocil ath --here;"  
  alias tath="java -jar ~/Apps/BrowserStackTunnel.jar 3TUmPOT0CxxeCR6V4KQE localhost,8000,0;"

  # ATG
  PATH=$PATH:$HOME/bin:$HOME/atgScripts
  alias satg="$HOME/atgScripts/atg start public_switching"
  alias katg="$HOME/atgScripts/atg kill-all"
  alias anta="cd $HOME/workspace/atg-backcountry-ca/modules/; ant all; cd -;"
  alias antd="cd $HOME/workspace/atg-backcountry-ca/modules/; ant update-data; cd -;"
  alias antf="cd $HOME/workspace/atg-backcountry-ca/modules/; ant full; cd -;"
  export ATG_HOME=/opt/atg/atg10.0.1                                                        
  export JBOSS_HOME=/opt/jboss-eap-5.0/jboss-as
  export CLASSPATH=.:$JBOSS_HOME/server/ATGProduction/lib/ojdbc6.jar:$CLASSPATH             
  export DYNAMO_HOME=/opt/atg/atg10.0.1/home                                                
  export DYNAMO_ROOT=/opt/atg/atg10.0.1                                                     
  export JAVA_VM=$JAVA_HOME/bin/java
  export ORACLE_SID=atg
  export PATH=.$JAVA_HOME/jre/bin:$PATH
  export PATH=.~/workspace/atg-backcountry-ca/jboss-resources/scripts:$PATH
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

# Dreamhost
if [[ `hostname -s` == "suhail" ]]; then
  alias ls="ls --color" # colors for ls
  export PYTHONPATH=$PYTHONPATH:/home/leopic/lib/python # adding lib/python to pythonpath
  pystall="python setup.py install --home=~" # install new modules
fi

# dandole color a los ls en mac
if [[ `hostname -s` == "lpicados-mbp" || `hostname -s` == "dev-mac" ]]; then
  alias ls="ls -G"
  export LSCOLORS=dxfxcxdxbxegedabagacad
fi

if [[ `hostname -s` == "dev-mac" ]]; then
  export BASEDIR=$HOME/Work/Checkouts/atg-backcountry-ca
  export STOREDIR=$BASEDIR/modules/Store
  export JBOSS_HOME="/Users/lpicado/Work/jboss-eap-5.0/jboss-as"
  export ATG_HOME="/Users/lpicado/Work/atg/atg10.0.1"
  export DYNAMO_HOME="$ATG_HOME/home"
  export PATH="$PATH:/Users/lpicado/Work/Checkouts/atg-backcountry-ca/jboss-resources/scripts"
  export JAVA_HOME="/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"
  alias sclb="java -jar ~/Apps/Sauce-Connect.jar bc_lpicado 475ef286-0787-4b04-ad48-041c89778e60"
  alias katg="atg kill-all"
  alias ratg="atg restart public"
  alias satg="atg start public"
  alias tatg="atg tail public"
  alias anta="cd /Users/lpicado/Work/Checkouts/atg-backcountry-ca/modules/; ant all; cd -;"
  alias antd="cd /Users/lpicado/Work/Checkouts/atg-backcountry-ca/modules/; ant update-data; cd -;"
  alias antf="cd /Users/lpicado/Work/Checkouts/atg-backcountry-ca/modules/; ant full; cd -;"
  alias bap="cd /Users/lpicado/Work/Checkouts/gearcloset-titanium; ti build -p ios; cd -;"
fi

# Handy to have
# key is corrupt, permissions to open
alias fixkey="sudo chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub"

