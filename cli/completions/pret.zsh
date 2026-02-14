#compdef pret

_pret() {
    local -a commands
    commands=(
        'init:Initialize Pret-a-Program in current project'
        'plan:Create a new plan document'
        'execute:Start execution with branch and tracking'
        'summarize:Generate post-work summary'
        'archive:Archive current context'
        'status:Show current workflow state'
        'check:Decision helper for workflow selection'
        'install-skills:Install AI tool skills'
    )

    if (( CURRENT == 2 )); then
        _describe 'command' commands
        return
    fi

    case "${words[2]}" in
        install-skills)
            _arguments \
                '--claude[Install Claude Code skills]' \
                '--cursor[Install Cursor rules]' \
                '--codex[Install Codex AGENTS.md]' \
                '--all[Install for all detected tools]'
            ;;
        execute)
            _arguments \
                '--phase=[Execute specific phase]:phase number' \
                '--branch=[Use custom branch name]:branch name' \
                '--no-branch[Skip branch creation]'
            ;;
        archive)
            _arguments \
                '--fresh[Start with clean context]' \
                '--seed[Carry forward completed summaries]'
            ;;
    esac
}

_pret
