# 安装zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

. $ZINIT_HOME/zinit.zsh

# 增强TAB
# zinit ice lucid wait; zinit light Aloxaf/fzf-tab
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# 语法高亮
zinit ice lucid wait atinit='zpcompinit'; zinit light zdharma-continuum/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait atload='_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions

# 补全
zinit light marlonrichert/zsh-autocomplete

# zinit ice blockf; zinit light zsh-users/zsh-completions
# 提示符
zinit ice depth=1; zinit light romkatv/powerlevel10k

# zsh-autocomplete 配置
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey -M menuselect '\r' .accept-line

# 加载OMZ插件
# zinit snippet OMZL::/completion.zsh
