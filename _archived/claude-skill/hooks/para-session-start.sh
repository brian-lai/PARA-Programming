#!/bin/bash
#
# PARA-Programming SessionStart Hook
# Provides contextual guidance when Claude Code starts
#

# Check if context directory exists
if [ ! -d "context" ]; then
    # PARA not initialized in this project
    cat <<'EOF'
{
  "systemMessage": "💡 PARA-Programming available\n   Run /para-init to set up | /para-help for guide"
}
EOF
    exit 0
fi

# PARA is initialized - check status
ACTIVE_PLANS=$(find context/plans -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
SUMMARIES=$(find context/summaries -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

# Check if context.md exists and extract current state
if [ -f "context/context.md" ]; then
    CONTEXT_SUMMARY=$(head -3 context/context.md | tail -1 | sed 's/^[[:space:]]*//')
else
    CONTEXT_SUMMARY="No active work"
fi

# Build status message with better formatting
STATUS_LINE="📋 PARA: ${ACTIVE_PLANS} plan(s) • ${SUMMARIES} summary(ies)"

# Add current work if meaningful
if [[ ! "$CONTEXT_SUMMARY" =~ "Ready to start" ]] && [ -n "$CONTEXT_SUMMARY" ]; then
    # Truncate and clean up the summary
    CLEAN_SUMMARY=$(echo "$CONTEXT_SUMMARY" | sed 's/\*\*//g' | cut -c1-60)
    if [ ${#CONTEXT_SUMMARY} -gt 60 ]; then
        CLEAN_SUMMARY="${CLEAN_SUMMARY}..."
    fi
    CURRENT_LINE="   Current: ${CLEAN_SUMMARY}"
else
    CURRENT_LINE="   Ready for new work"
fi

# Output formatted status
cat <<EOF
{
  "systemMessage": "${STATUS_LINE}\n${CURRENT_LINE}\n   Commands: /para-plan /para-status /para-help"
}
EOF

exit 0
