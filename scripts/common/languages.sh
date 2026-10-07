echo
echo "Linking installed JDKs into /Library/Java/JavaVirtualMachines"
for formula in openjdk openjdk@17 openjdk@21 openjdk@25; do
  jdk_path="$(brew --prefix "$formula" 2>/dev/null)/libexec/openjdk.jdk"
  if [[ -d "$jdk_path" ]]; then
    link_name="${formula//@/-}"
    sudo ln -sfn "$jdk_path" "/Library/Java/JavaVirtualMachines/${link_name}.jdk"
  fi
done

echo "Removing any dangling JDK symlinks (formula no longer installed)"
for link in /Library/Java/JavaVirtualMachines/openjdk*.jdk; do
  if [[ -L "$link" && ! -e "$link" ]]; then
    echo "Removing dangling symlink: $link"
    sudo rm "$link"
  fi
done

echo
echo "Cleaning up leftover PATH/CPPFLAGS exports from an older version of this script"
if [[ -f ~/.zshenv ]]; then
  sed -i '' '\#^export PATH="/opt/homebrew/opt/openjdk/bin#d; \#^export CPPFLAGS="-I/opt/homebrew/opt/openjdk#d' ~/.zshenv
fi

echo
echo "Configuring JAVA_HOME (highest installed LTS JDK: 17, 21, 25, 29, ...; falls back to 25)"
JAVA_HOME_MARKER="# JAVA_HOME: highest installed LTS JDK"
if ! grep -qF "$JAVA_HOME_MARKER" ~/.zshrc 2>/dev/null; then
  # Remove any older static JAVA_HOME line from a previous version of this script
  sed -i '' '/^export JAVA_HOME=/d' ~/.zshrc
  cat >> ~/.zshrc <<EOF

$JAVA_HOME_MARKER (17, 21, 25, 29, ...), falling back to 25
_java_lts_major=\$(/usr/libexec/java_home -V 2>&1 >/dev/null | awk '{print \$1}' | cut -d. -f1 | awk '(\$1+0) % 4 == 1' | sort -n | tail -1)
export JAVA_HOME="\$(/usr/libexec/java_home -v "\${_java_lts_major:-25}" 2>/dev/null || /usr/libexec/java_home -v 25)"
unset _java_lts_major
EOF
fi

echo
echo "Configuring kubectl completion"
if ! grep -qF "kubectl completion zsh" ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc <<'EOF'

# kubectl completion
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k
autoload -Uz compinit
compinit
EOF
fi

echo
echo "Adding the asdf Ruby plugin (does not touch your existing rbenv install)"
asdf plugin add ruby 2>/dev/null || true

echo "Copying .irbrc"
cp files/.irbrc ~/.irbrc
