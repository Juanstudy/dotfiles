# Completion for cd command
# Provides directory completion with preview

complete -c cd -f -a "(fd --type d --hidden 2>/dev/null)" -d "Directory"