# Bash completion for pret CLI
_pret() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local commands="init plan execute summarize archive status check install-skills"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands --version --help" -- "$cur"))
        return
    fi

    case "${COMP_WORDS[1]}" in
        install-skills)
            COMPREPLY=($(compgen -W "--claude --cursor --codex --all" -- "$cur"))
            ;;
        execute)
            COMPREPLY=($(compgen -W "--phase= --branch= --no-branch" -- "$cur"))
            ;;
        archive)
            COMPREPLY=($(compgen -W "--fresh --seed" -- "$cur"))
            ;;
    esac
}
complete -F _pret pret
