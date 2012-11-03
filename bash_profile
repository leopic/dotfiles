# aliases
alias l1="ls -ogh"
alias log="git log --no-merges"
alias untar="tar -xzvf"
alias rmdir="rm -rf"
alias cpdir="cp -r"
alias psg="ps aux | grep"

# Z: z is the new j, yo.
if [ -d ~/Apps/z ]; then
  . ~/Apps/z/z.sh
else
  echo "No Z, cloning"
  cd ~ && mkdir Apps && git clone git://github.com/rupa/z.git
  . ~/Apps/z/z.sh
fi

# If git vundle doesn't exist, clone it.
if [ ! -d ~/.vim/bundle/vundle ]; then
  cd ~/ && git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 
fi

# exports
export EDITOR='vim'
bind 'set completion-ignore-case on'
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# Ubuntu only 
os=`uname`
if [[ ${os} == "Linux" ]]; then
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_32"
  export JAVA_HOME="/usr/lib/jvm/jdk1.6.0_32"
  PATH=$HOME/Apps/Sublime\ Text\ 2/:"$PATH"

  alias apre="sudo /etc/init.d/apache2 restart"
  alias aplog="tail -f /var/log/apache2/error.log"
  alias ij="/home/leopic/Apps/idea-IU-95.627/bin/./idea.sh"
  alias l2="ls -1Fsh --group-directories-first"

  #if [ -f ~/.bash_profile ]; then
    #. ~/.bash_profile
  #fi
fi

# branch in prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '

if [[ ${os} == "Darwin" ]]; then
  __git_ps1 () 
  { 
      local b="$(git symbolic-ref HEAD 2>/dev/null)";
      if [ -n "$b" ]; then
          printf " (%s)" "${b##refs/heads/}";
      fi
  }
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '
fi


# Handy to have
# key is corrupt, permissions to open
alias fixkey="sudo chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub"

# Perm'ing your key: TODO, make it werk.
# ssh-add
# exec ssh-agent bash
#
