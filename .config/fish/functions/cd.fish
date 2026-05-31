# Custom cd function with fzf integration
# Shows only subdirectories from current location

function cd
    if test (count $argv) -eq 0
        # No arguments → open fzf with only subdirectories from current location
        
        # Get list of directories
        set -l directories (fd --type d --max-depth 1 --hidden 2>/dev/null)
        
        if test (count $directories) -eq 0
            echo "No subdirectories found"
            return 1
        end
        
        # Use fzf to select a directory
        set -l selected_dir (
            printf '%s\n' $directories \
            | fzf --prompt="cd > " \
                  --height=~80% \
                  --reverse \
                  --preview="ls -la --color=always {}" \
                  --preview-window="right:50%"
        )
        
        # If user selected something
        if test -n "$selected_dir"
            if test -d "$selected_dir"
                builtin cd "$selected_dir"
            else
                builtin cd "$PWD/$selected_dir"
            end
        and ls --color=always
    end
    else if test "$argv" = "-"
        builtin cd $argv
        and ls --color=always
    else
        builtin cd $argv
        and ls --color=always
    end
end