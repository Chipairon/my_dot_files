#!/usr/bin/env bash

############################  BASIC SETUP TOOLS
msg() {
  printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

variable_set() {
  if [ -z "$1" ]; then
    error "You must have your HOME environmental variable set to continue."
  fi
}

do_backup() {
  if [ -e "$2" ] || [ -e "$3" ] || [ -e "$4" ]; then
    today=`date +%Y%m%d_%s`
    for i in "$2" "$3" "$4"; do
        [ -e "$i" ] && [ ! -L "$i" ] && mv "$i" "$i.$today";
    done
    ret="$?"
    success "$1"
  fi
}


############################ MAIN()
variable_set "$HOME"
#program_exists "vim" "To install $app_name you first need to install Vim."

do_backup "Your old stuff has a suffix now and looks like .xx.`date +%Y%m%d%S`" \
        "$HOME/.mybashrc" \
        "$HOME/.tmux.conf" \
        "$HOME/.bash_prompt_line"

ln -sf "`pwd`/.mybashrc" "$HOME/.mybashrc"
ln -sf "`pwd`/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "`pwd`/.bash_prompt_line" "$HOME/.bash_prompt_line"

# Add mybashrc to bashrc if it is not there:
if ! grep -qe "mybashrc" "$HOME/.bashrc"; then
  echo "# Loading mybash config:" >> $HOME/.bashrc
  echo "source ~/.mybashrc" >> $HOME/.bashrc
fi

# Add bashrc to bash_profile if it is not there:
if ! grep -qe "bashrc" "$HOME/.bash_profile"; then
  echo "# Loading bashrc config:" >> $HOME/.bash_profile
  echo "source ~/.bashrc" >> $HOME/.bash_profile
fi
