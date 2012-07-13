# aliases
alias lls="ls -ogh"
alias log="git log --no-merges"
alias reap="sudo /etc/init.d/apache2 restart"

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

ssh-add
