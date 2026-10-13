#!/usr/bin/env bash
set -e

# Detect shell config file
if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ]; then
  # Only target .bash_profile if it already exists (typical on macOS).
  # On Linux/WSL it usually doesn't, and creating it would stop bash from
  # reading .profile — which is what sources .bashrc on Ubuntu.
  if [ -f "$HOME/.bash_profile" ]; then
    SHELL_RC="$HOME/.bash_profile"
  else
    SHELL_RC="$HOME/.bashrc"
  fi
else
  SHELL_RC="$HOME/.profile"
fi

echo "→ Installing Claude Code aliases into $SHELL_RC..."

ALIASES=$(cat <<'EOF'

# Claude Code aliases
alias ccs='claude --dangerously-skip-permissions --model sonnet'
alias cco='claude --dangerously-skip-permissions --model opus'
alias cch='claude --dangerously-skip-permissions --model haiku'
EOF
)

# Check for duplicates
if grep -q "alias ccs=" "$SHELL_RC" 2>/dev/null; then
  echo "⚠️  Aliases already present in $SHELL_RC — skipping."
  exit 0
fi

echo "$ALIASES" >> "$SHELL_RC"
echo "✓ Aliases added to $SHELL_RC"

echo ""
echo "✅ Done! Open a new terminal or run:"
echo "   source $SHELL_RC"
echo ""
echo "   cco → Opus   |   ccs → Sonnet   |   cch → Haiku"
