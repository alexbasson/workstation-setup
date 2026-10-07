echo
echo 'Customizing OS X configuration'

# set menu clock
# see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
defaults write com.apple.menuextra.clock "DateFormat" 'EEE MMM d  h:mm:ss a'
killall SystemUIServer

# hide the dock
defaults write com.apple.dock autohide -bool true
killall Dock

# fast key repeat rate, requires reboot to take effect
defaults write ~/Library/Preferences/.GlobalPreferences KeyRepeat -int 1
defaults write ~/Library/Preferences/.GlobalPreferences InitialKeyRepeat -int 15

# set finder to display full path in title bar
defaults write com.apple.finder '_FXShowPosixPathInTitle' -bool true

# stop Photos from opening automatically
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
#to revert use defaults -currentHost delete com.apple.ImageCapture disableHotPlug

# modify appearance of dock: remove standard icons, pin what's actually in use
#
# dockutil writes via `defaults`, which cfprefsd caches in memory. Firing
# --remove/--add calls back-to-back (especially while the live Dock process
# is also reading/writing the same plist) can race with that cache and
# silently drop an entry. Killing Dock first removes one writer from the
# race, and verifying each add against the plist itself (not `dockutil
# --list`, which can also read a stale cache) with a retry makes this
# self-healing instead of relying on a fixed delay being "long enough".
killall Dock 2>/dev/null
sleep 1

dockutil --list | awk -F\t '{print "dockutil --remove \""$1"\" --no-restart"}' | sh
killall cfprefsd 2>/dev/null
sleep 1

add_to_dock() {
  local app="$1"
  [[ -e "$app" ]] || return 0
  local encoded="${app// /%20}"
  local attempt
  for attempt in 1 2 3; do
    if defaults read com.apple.dock persistent-apps 2>/dev/null | grep -qF "$encoded"; then
      return 0
    fi
    dockutil --add "$app" --no-restart >/dev/null
    killall cfprefsd 2>/dev/null
    sleep 1
  done
  echo "Warning: could not pin '$app' to the Dock after 3 attempts" >&2
}

add_to_dock "/Applications/Slack.app"
add_to_dock "/Applications/Google Chrome.app"
add_to_dock "/Applications/zoom.us.app"
add_to_dock "/Applications/Microsoft Teams.app"
add_to_dock "/Applications/iTerm.app"
add_to_dock "/Applications/Miro.app"
add_to_dock "/System/Applications/Notes.app"
add_to_dock "/Applications/Tuple.app"
add_to_dock "/Applications/MacDown 3000.app"

# These are per-user Chrome "installed as app" shortcuts (Chrome menu > More
# Tools > Create Shortcut), not Homebrew-managed. They won't exist on a fresh
# machine until recreated from Chrome, so add_to_dock just skips them (its
# own existence check is a no-op since the function already no-ops on a
# missing path).
add_to_dock "$HOME/Applications/Chrome Apps.localized/Gmail.app"
add_to_dock "$HOME/Applications/Chrome Apps.localized/Gcal.app"

killall Dock

# Force Preference Refresh
killall -u $USER cfprefsd

echo
echo "Configuring iTerm"
cp files/com.googlecode.iterm2.plist ~/Library/Preferences

echo "Configuring Rectangle"
cp files/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist
open /Applications/Rectangle.app

echo "Configuring FlyCut"
open /Applications/Flycut.app
