#!/usr/bin/env bash
# POSIX sh compatible: also works when run as `sh install.sh`.
set -e

# ---------------------------------------------------------------------------
# Pick which shell we're configuring for.
#
# Prefer the user's login shell ($SHELL): `curl ... | bash` always runs this
# script under bash, so $BASH_VERSION/$ZSH_VERSION reflect the interpreter, not
# the shell the user actually uses. Fall back to those only if $SHELL is unset.
# ---------------------------------------------------------------------------
shell_name="${SHELL##*/}"
if [ -z "$shell_name" ]; then
  if [ -n "$ZSH_VERSION" ]; then
    shell_name="zsh"
  elif [ -n "$BASH_VERSION" ]; then
    shell_name="bash"
  fi
fi

case "$shell_name" in
  zsh)
    # Interactive zsh (login or not, Linux or macOS) always reads ~/.zshrc.
    SHELL_RC="$HOME/.zshrc"
    ;;
  bash)
    # Interactive non-login bash (Linux terminals, VSCode, WSL) reads ~/.bashrc,
    # so that's the right place for aliases everywhere.
    SHELL_RC="$HOME/.bashrc"
    ;;
  *)
    # sh/dash/ksh or unknown: ~/.profile is POSIX and widely sourced.
    SHELL_RC="$HOME/.profile"
    ;;
esac

echo "→ Installing Claude Code aliases into $SHELL_RC..."

ALIASES=$(cat <<'EOF'

# Claude Code aliases
alias ccs='claude --dangerously-skip-permissions --model sonnet'
alias cco='claude --dangerously-skip-permissions --model opus'
alias cch='claude --dangerously-skip-permissions --model haiku'
EOF
)

# Create the target file if it doesn't exist yet.
touch "$SHELL_RC"

# Check for duplicates before appending.
if grep -q "alias ccs=" "$SHELL_RC" 2>/dev/null; then
  echo "⚠️  Aliases already present in $SHELL_RC — skipping."
else
  echo "$ALIASES" >> "$SHELL_RC"
  echo "✓ Aliases added to $SHELL_RC"
fi

# ---------------------------------------------------------------------------
# macOS bash: Terminal/iTerm open *login* shells, which read ~/.bash_profile
# (or ~/.bash_login / ~/.profile) and do NOT read ~/.bashrc. Make sure a login
# file sources ~/.bashrc so the aliases load there too.
#
# We only do this on macOS: on Linux, creating ~/.bash_profile would stop bash
# from reading ~/.profile (which already sources ~/.bashrc for login shells).
# ---------------------------------------------------------------------------
if [ "$shell_name" = "bash" ] && [ "$(uname -s)" = "Darwin" ]; then
  login_rc=""
  for f in "$HOME/.bash_profile" "$HOME/.bash_login" "$HOME/.profile"; do
    if [ -f "$f" ]; then
      login_rc="$f"
      break
    fi
  done
  # None exist: create ~/.bash_profile (bash's preferred login file).
  [ -z "$login_rc" ] && login_rc="$HOME/.bash_profile"

  if grep -q '\.bashrc' "$login_rc" 2>/dev/null; then
    : # already sources .bashrc
  else
    cat >> "$login_rc" <<'EOF'

# Load interactive bash config (aliases, etc.) in login shells
if [ -f "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi
EOF
    echo "✓ $login_rc now sources ~/.bashrc (needed for macOS login shells)"
  fi
fi

echo ""
echo "✅ Done! Open a new terminal or run:"
echo "   . $SHELL_RC"
echo ""
echo "   cco → Opus   |   ccs → Sonnet   |   cch → Haiku"
