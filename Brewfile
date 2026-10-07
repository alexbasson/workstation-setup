# Single source of truth for this machine's Homebrew-managed packages.
# Install/update everything here with: brew bundle install --file=Brewfile
# Regenerate a diff against the live machine with: brew bundle dump --force --file=-

cask_args adopt: true

tap "bufbuild/buf"
tap "spring-io/tap"

# Formulas
brew "asdf"
brew "auth0"
brew "bat"
brew "beads"
brew "bufbuild/buf/buf", trusted: true
brew "colima"
brew "direnv"
brew "dockutil"
brew "gh"
brew "git"
brew "go"
brew "gradle"
brew "grpcurl"
brew "jq"
brew "kubernetes-cli"
brew "libpq", link: true
# Runtime dependency of the asdf-built Ruby (psych/YAML support), not just a
# build-time one — keep it explicit so `brew autoremove` doesn't reclaim it.
brew "libyaml"
brew "maven"
brew "node"
brew "openjdk"
brew "openjdk@17"
brew "openjdk@21", link: true
brew "openjdk@25"
brew "pandoc"
brew "pipenv"
brew "spring-io/tap/spring-boot", trusted: true

# Casks
cask "1password-cli"
cask "claude-code"
cask "docker-desktop"
cask "firefox"
cask "flycut"
cask "gcloud-cli"
cask "gitup-app"
cask "google-chrome"
cask "insomnia"
cask "insta360-link-controller"
cask "iterm2"
cask "jetbrains-toolbox"
cask "logitech-g-hub"
cask "macdown-3000"
cask "microsoft-teams"
cask "notion"
cask "rectangle"
cask "slack"
cask "sourcetree"
cask "steermouse"
cask "tuple"
cask "visual-studio-code"
cask "zoom"
