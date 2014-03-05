# aliases
alias ls="ls -F"
alias l1="ls -oghF"
alias log="git log --no-merges --name-only"
alias untar="tar -xzvf"
alias rmdir="rm -rf"
alias cpdir="cp -r"
alias psg="ps aux | grep"
alias p2p="git pull origin develop && git checkout develop && git pull"
which vim > /dev/null 2>&1 && alias vi=vim

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
#bind 'set completion-ignore-case on'
#shopt -s histappend
#shopt -s checkwinsize

# Ubuntu only 
if [[ `hostname -s` == "leopic-Latitude-E6520" ]]; then
  alias ls="ls --color -F"
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
  alias ls="ls --color -F"
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
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)➔ '

# adding git branch to prompt in DH/Mac
if [[ `hostname -s` == "dev-mac" ]] || [[ `hostname -s` == "suhail" ]]; then
  __git_ps1 () 
  { 
      local b="$(git symbolic-ref HEAD 2>/dev/null)";
      if [ -n "$b" ]; then
          printf " (%s)" "${b##refs/heads/}";
      fi
  }
  #PS1="\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;37m\]:\W\[\e[0m\]\[\e[01;37m\]>\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]"
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '
fi

# Dreamhost
if [[ `hostname -s` == "suhail" ]]; then
  alias ls="ls --color -F" # colors for ls
  export PYTHONPATH=$PYTHONPATH:/home/leopic/lib/python # adding lib/python to pythonpath
  pystall="python setup.py install --home=~" # install new modules
fi

# dandole color a los ls en mac
if [[ `hostname -s` == "lpicados-mbp" || `hostname -s` == "dev-mac" ]]; then
  alias ls="ls -G -F"
  export LSCOLORS=dxfxcxdxbxegedabagacad
fi

if [[ `hostname -s` == "dev-mac" ]]; then
  #export NODE_STARTS_CRON=true
  #export NODE_MINI_STORIES=true
  export BASEDIR=$HOME/Work/Checkouts/atg
  export STOREDIR=$BASEDIR/modules/Store
  export JBOSS_HOME="/Users/lpicado/Work/jboss-eap-5.0/jboss-as"
  export ATG_HOME="/Users/lpicado/Work/atg/atg10.0.1"
  export DYNAMO_HOME="$ATG_HOME/home"
  export PATH="$PATH:/Users/lpicado/Work/Checkouts/atg/jboss-resources/scripts"
  export JAVA_HOME="/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"
  alias sclb="java -jar ~/Apps/Sauce-Connect.jar bc_lpicado 475ef286-0787-4b04-ad48-041c89778e60"
  alias katg="cd /Users/lpicado/Work/Checkouts/atg/jboss-resources/scripts; ./atg kill-all; cd -;"
  alias satg="cd /Users/lpicado/Work/Checkouts/atg/jboss-resources/scripts; ./atg start public; cd -;"
  alias tatg="cd /Users/lpicado/Work/Checkouts/atg/jboss-resources/scripts; ./atg tail public; cd -"
  alias anta="cd /Users/lpicado/Work/Checkouts/atg/modules/; ant all; cd -;"
  alias antd="cd /Users/lpicado/Work/Checkouts/atg/modules/; ant update-data; cd -;"
  alias antf="cd /Users/lpicado/Work/Checkouts/atg/modules/; ant full; cd -;"
  alias bap="cd /Users/lpicado/Work/Checkouts/bc-mobile-app; ti clean; ti build -p ios -S 6.1 --tall --retina -F iphone --liveview; cd -;"
  alias bap7="cd /Users/lpicado/Work/Checkouts/bc-mobile-app; ti clean; ti build -p ios -S 7.0.3 -F iphone --liveview; cd -;"
  alias bat="cd /Users/lpicado/Work/Checkouts/bc-mobile-app; ti clean; ti build -p ios -S 6.1 --retina -F ipad --liveview; cd -;"
  alias bat7="cd /Users/lpicado/Work/Checkouts/bc-mobile-app; ti clean; ti build -p ios -S 7.0.3 --retina -F ipad --liveview; cd -;"
fi

# Handy to have
# key is corrupt, permissions to open
alias fixkey="sudo chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub"

export NODE_ENV='test'

function up {
  if [ "$#" -eq 0 ] ; then
    echo "Up to where?"
    return 1
  fi

  times=$1
  target="$2"
  while [ $times -gt 0 ] ; do
    target="../$target"
    times=$((times - 1))
  done
  cd $target
}
export PATH=/usr/local/bin:$PATH
export LANG="en_US.UTF-8"
