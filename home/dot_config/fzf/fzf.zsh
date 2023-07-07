# Setup fzf
# ---------

# Auto-completion
# Key bindings
if [[ -d $HOME/.fzf ]] {
  . "$HOME/.fzf/shell/completion.zsh"
  . "$HOME/.fzf/shell/key-bindings.zsh"
  PATH="$HOME/.fzf/bin:$PATH"
} else {
  . "/usr/share/fzf/completion.zsh"
  . "/usr/share/fzf/key-bindings.zsh"
}


# custom setting
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --hidden --exclude .git'
# --bind ?:toggle-preview,alt-w:toggle-preview-wrap
export FZF_DEFAULT_OPTS='
--height 60% --layout=reverse --border --info=inline --pointer '➤' --marker '┃'
--cycle
--bind alt-p:preview-up,alt-n:preview-down
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:cyan,bg+:99,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
# export FZF_CTRL_T_OPTS="
#   --preview 'bat -n --color=always {}'
#   --bind 'ctrl-/:change-preview-window(down|hidden|)'
# "

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"

export FZF_ALT_C_COMMAND="fd --type d --hidden"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# 历史记录
# export FZF_CTRL_R_OPTS='--no-sort --exact'
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

fh() {
  fd -H $@ ~ | fzf
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
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

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
