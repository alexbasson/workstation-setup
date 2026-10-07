echo
if [[ -d "$HOME/.bun" ]]; then
  echo "bun is already installed"
else
  echo "Installing bun"
  curl -fsSL https://bun.sh/install | bash
fi

if ! grep -qF 'BUN_INSTALL' ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc <<'EOF'

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
EOF
fi
