# aliases
alias be="bundle exec"
alias cpdir="cp -r"
alias gadd="git add -A ."
alias gap="git add -p"
alias glog="git log --no-merges --name-only"
alias gp="git pull"
alias gprev="git diff -w head"
alias gprevs="git diff -w --staged head"
alias gundo="git reset --soft HEAD^ && git restore --staged ."
alias l1="ls -oghF"
alias log="git log --no-merges --name-only"
alias ls="ls -G -F"
alias rebae="git rebase -i master"
alias redo="git reset --soft HEAD^ && git reset HEAD ."
alias rmdir="rm -rf"
alias tree="git logj"
alias untar="tar -xzvf"

# exports
export EDITOR='vim'
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
export LANG="en_US.UTF-8"

# functions
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

function gcom() {
  git commit -v -m "$1"
}

# etc
which vim > /dev/null 2>&1 && alias vi=vim

