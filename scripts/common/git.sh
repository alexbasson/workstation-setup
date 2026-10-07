echo
echo "Setting global Git configurations"
git config --global core.editor "/usr/bin/vim"
git config --global transfer.fsckobjects true
git config --global url."git@github.com:".insteadOf "https://github.com/"

mkdir -p ~/.git_templates
git config --global init.templateDir ~/.git_templates
echo "ref: refs/heads/main" > ~/.git_templates/HEAD

# Clean up leftover git-duet env vars from older versions of this script
if [[ -f ~/.zshenv ]] && grep -qF "GIT_DUET_" ~/.zshenv; then
  sed -i '' '/^export GIT_DUET_/d' ~/.zshenv
fi
