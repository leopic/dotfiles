# aliases
alias ls="ls -F"
alias l1="ls -oghF"
alias log="git log --no-merges --name-only"
alias untar="tar -xzvf"
alias rmdir="rm -rf"
alias cpdir="cp -r"
alias psg="ps aux | grep"
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
#if [ ! -f ~/.git-completion.sh ]; then
  #cd ~/ && wget -O .git-completion.sh --no-check-certificate https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 
#fi
#. ~/.git-completion.sh

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
  #export JDK_HOME="/usr/lib/jvm/jdk1.6.0_32"
  #export JAVA_HOME="/usr/lib/jvm/jdk1.6.0_32"
  # Agregando variable Android SDK
  #export ANDROID_SDK="/home/leopic/Apps/adt-bundle-linux-x86_64-20130729"
  # Agregando Android SDK al Path
  #PATH=$HOME/Apps/WebStorm-129.664/bin/:"$PATH"
  #PATH=/home/leopic/Apps/adt-bundle-linux-x86_64-20130729/sdk/platform-tools:"$PATH"
  #PATH=/home/leopic/Apps/adt-bundle-linux-x86_64-20130729/sdk/tools:"$PATH"
  #complete -W "$(teamocil --list)" teamocil

  alias apre="sudo /etc/init.d/apache2 restart"
  alias aplog="tail -f /var/log/apache2/error.log"
  #alias ij="/home/leopic/Apps/idea-IU-95.627/bin/./idea.sh"
  #alias tis="/home/leopic/Apps/Titanium_Studio/TitaniumStudio"
  #alias titanium.py=$HOME/.titanium/mobilesdk/linux/3.1.2.GA/titanium.py
  alias l2="ls -1Fsh --group-directories-first"
  alias open="xdg-open"
  alias myip="ifconfig | grep 'inet addr:' | head -1"
  #alias sath="cd /var/www/athlete/src; export USE_MYSQL=1; sudo pip install -r ../requirements/global.txt; sudo pip install -r ../requirements/dev.txt; python manage.py syncdb; python manage.py migrate; python manage.py runserver;"
  #alias tmath="teamocil ath --here;"  
  #alias tath="java -jar ~/Apps/BrowserStackTunnel.jar 3TUmPOT0CxxeCR6V4KQE localhost,8000,0;"
fi

# branch in prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)➔ '

# Dreamhost
if [[ `hostname -s` == "suhail" ]]; then
  __git_ps1 () 
  { 
      local b="$(git symbolic-ref HEAD 2>/dev/null)";
      if [ -n "$b" ]; then
          printf " (%s)" "${b##refs/heads/}";
      fi
  }
  #PS1="\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;37m\]:\W\[\e[0m\]\[\e[01;37m\]>\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]"
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '
  alias ls="ls --color -F" # colors for ls
  export PYTHONPATH=$PYTHONPATH:/home/leopic/lib/python # adding lib/python to pythonpath
  pystall="python setup.py install --home=~" # install new modules
fi

if [[ `hostname -s` == "leos-mbp" ]]; then
  # dandole color a los ls en mac
  alias ls="ls -G -F"
  export LSCOLORS=dxfxcxdxbxegedabagacad
  export LC_ALL=en_US.UTF-8  
  export LANG=en_US.UTF-8
  export PATH=/Users/leo/Apps/arcanist/bin:$PATH
  #export JAVA_HOME="/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"
  #export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home"
fi

# Handy to have
# key is corrupt, permissions to open
alias fixkey="sudo chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub"

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
