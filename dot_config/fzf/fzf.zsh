# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.zsh"

# custom setting
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --hidden --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"

export FZF_ALT_C_COMMAND="fd --type d --hidden"

# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --exact 
export FZF_DEFAULT_OPTS='
--height 60% --layout=reverse --border --info=inline

--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:cyan,bg+:99,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
#W 历史记录
export FZF_CTRL_R_OPTS='--no-sort --exact'

# Directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# f mv # To move files. You can write the destination after selecting the files.
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}
# Exit if there's no match (--exit-0)
# Bypass fuzzy finder if there's only one match (--select-1)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-nvim} "$file"
  fi
}

