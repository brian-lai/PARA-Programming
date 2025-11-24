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
  "systemMessage": "💡 PARA-Programming available. Run /para-init to set up workflow structure, or /para-help for guide."
}
EOF
    exit 0
fi

# PARA is initialized - check status
ACTIVE_PLANS=$(find context/plans -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
SUMMARIES=$(find context/summaries -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

# Check if context.md exists and extract current state
if [ -f "context/context.md" ]; then
    CONTEXT_SUMMARY=$(head -3 context/context.md | tail -1)
else
    CONTEXT_SUMMARY="No active work"
fi

# Build status message
STATUS_MSG="📋 PARA Status: $ACTIVE_PLANS plan(s), $SUMMARIES summary(ies)"

# Add current work if not "Ready to start"
if [[ ! "$CONTEXT_SUMMARY" =~ "Ready to start" ]] && [ -n "$CONTEXT_SUMMARY" ]; then
    STATUS_MSG="$STATUS_MSG | Current: ${CONTEXT_SUMMARY:0:50}..."
fi

# Output brief status
cat <<EOF
{
  "systemMessage": "$STATUS_MSG | Commands: /para-plan /para-status /para-help"
}
EOF

exit 0
