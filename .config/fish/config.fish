if status is-interactive
    if not functions -q fisher
        curl -sL https://git.io/fisher | source
        fisher install jorgebucaran/fisher
    end

end

# Linux
#set -x PATH $HOME/.local/bin $HOME/.opencode/bin $HOME/.bun/bin /usr/local/bin $HOME/.config $HOME/.cargo/bin /usr/local/lib/* $PATH
#set BREW_BIN /home/linuxbrew/.linuxbrew/bin/brew
#fish_add_path $HOME/.local/bin
#fish_add_path $HOME/.local/share/opencode/bin
#fish_add_path $HOME/.opencode/bin
#fish_add_path $HOME/.bun/bin
#fish_add_path $HOME/.cargo/bin
#fish_add_path /usr/local/bin
# Only eval brew shellenv if brew is installed (not on Termux)
#if test $IS_TERMUX -eq 0; and set -q BREW_BIN; and test -f $BREW_BIN
#    eval ($BREW_BIN shellenv)
#end

# PATH
set -x PATH \
    $HOME/.local/bin \
    $HOME/.opencode/bin \
    $HOME/.volta/bin \
    $HOME/.bun/bin \
    $HOME/.nix-profile/bin \
    /nix/var/nix/profiles/default/bin \
    /usr/local/bin \
    $HOME/.config \
    $HOME/.cargo/bin \
    /usr/local/lib/* \
    $PATH

# Homebrew (solo si lo usas en Linux)
set -l BREW_BIN /home/linuxbrew/.linuxbrew/bin/brew
if test -f $BREW_BIN
    eval ($BREW_BIN shellenv)
end

# Start tmux/zellij
if not set -q TMUX
    tmux
end

# Initialize tools
starship init fish | source
zoxide init fish | source
atuin init fish | source
if command -v fzf &>/dev/null
    fzf --fish | source
end

set -x PATH $HOME/.cargo/bin $PATH

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'

if not test -d ~/.config/fish/completions
    mkdir -p ~/.config/fish/completions
end

if not test -f ~/.config/fish/completions/.initialized
    if not test -d ~/.config/fish/completions
        mkdir -p ~/.config/fish/completions
    end
    carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish
    touch ~/.config/fish/completions/.initialized
end

carapace _carapace | source
set -g fish_greeting ""

Enable vi modefish_vi_key_bindings

set -gx EDITOR nvim
set -gx VISUAL nvim

#set api keys
export CROFAI_API_KEY="nahcrof_xOSnvCyyhbesMioEebmP"

## alias
alias ls='eza --color-scale-mode=fixed --icons=always --grid'
alias nivm='nvim'
alias c='clear'
alias cat='bat'
alias e='exit'

set -l foreground F3F6F9 normal
set -l selection 263356 normal
set -l comment 8394A3 brblack
set -l red CB7C94 red
set -l orange DEBA87 orange
set -l yellow FFE066 yellow
set -l green B7CC85 green
set -l purple A3B5D6 purple
set -l cyan 7AA89F cyan
set -l pink FF8DD7 magenta

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
clear

# Added path of opencode
fish_add_path "/home/juan-arch/.cache/.bun/bin"

# pnpm
set -gx PNPM_HOME "/home/juan-arch/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
