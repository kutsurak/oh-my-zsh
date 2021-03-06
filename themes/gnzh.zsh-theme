# ZSH Theme - Preview: http://dl.dropbox.com/u/4109351/pics/gnzh-zsh-theme.png
# Based on bira theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%M%f' # no SSH
fi


local return_code="%(?..%F{red}%? ↵%f)"

local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"
local rvm_ruby=''
if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect user-local rvm installation
  rvm_ruby='%F{red}‹$(${HOME}/.rvm/bin/rvm-prompt i v g s)›%f'
elif which rvm-prompt &> /dev/null; then # detect system-wide rvm installation
  rvm_ruby='%F{red}‹$(rvm-prompt i v g s)›%f'
elif which rbenv &> /dev/null; then # detect Simple Ruby Version Management
  rvm_ruby='%F{red}‹$(rbenv version | sed -e "s/ (set.*$//")›%f'
fi

ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
ZSH_THEME_GIT_PROMPT_STASHED="$PR_BOLD$PR_RED ⚠"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$PR_BOLD$PR_RED ⇊"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$PR_BOLD$PR_RED ⇈"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$PR_BOLD$PR_RED ⇅"


local git_branch='$(git_prompt_info)$(git_prompt_status)$(git_remote_status)%{$PR_NO_COLOR%}'

#PROMPT="${user_host} ${current_dir}${rvm_ruby}${git_branch}$PR_PROMPT "
PROMPT="╭─${user_host} ${current_dir}${rvm_ruby}${git_branch}
╰─($PR_YELLOW%D{%d-%m-%Y %T} $PR_CYAN%!$PR_NO_COLOR)$PR_PROMPT "
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=" on $PR_BOLD$PR_GREEN"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$PR_NO_COLOR%}"
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}‹"
#ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$PR_NO_COLOR%}"
