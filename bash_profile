# aliases
alias l1="ls -ogh"
alias l2="ls -1Fsh --group-directories-first"
alias log="git log --no-merges"
alias apre="sudo /etc/init.d/apache2 restart"
alias aplog="tail -f /var/log/apache2/error.log"
alias ij="/home/leopic/Apps/idea-IU-95.627/bin/./idea.sh"
alias untar="tar -xzvf"

#git
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\h\[\033[00m\]:\[\033[00;31m\]\W\[\033[00m\]$(__git_ps1)\$ '

# agregar a ubuntu
# if [ -f ~/.bash_profile ]; then
#     . ~/.bash_profile
# fi

# key
# chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
#

# TODO: check if it exists.
#cd ~
#mkdir Apps
#git clone git://github.com/rupa/z.git
. ~/Apps/z/z.sh

export EDITOR='vim'
PATH=$HOME/Apps/Sublime\ Text\ 2/:"$PATH"

export JDK_HOME="/usr/lib/jvm/jdk1.6.0_32"
export JAVA_HOME="/usr/lib/jvm/jdk1.6.0_32"

#ssh-add

