echo
echo "Setting up scheduled Homebrew maintenance"

LABEL="com.user.brewmaintenance"

SCRIPTS_DIR="$HOME/scripts"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

SOURCE_SCRIPT="${MY_DIR}/files/brew-maintenance.sh"
SOURCE_PLIST="${MY_DIR}/files/${LABEL}.plist"

DEST_SCRIPT="$SCRIPTS_DIR/brew-maintenance.sh"
DEST_PLIST="$LAUNCH_AGENTS_DIR/${LABEL}.plist"

mkdir -p "$SCRIPTS_DIR" "$LAUNCH_AGENTS_DIR"

cp "$SOURCE_SCRIPT" "$DEST_SCRIPT"
chmod 755 "$DEST_SCRIPT"

sed "s|/Users/<HOME_DIR>|$HOME|g" "$SOURCE_PLIST" > "$DEST_PLIST"
chmod 644 "$DEST_PLIST"

if launchctl print "gui/$(id -u)/$LABEL" &>/dev/null; then
  launchctl bootout "gui/$(id -u)/$LABEL"
fi

launchctl bootstrap "gui/$(id -u)" "$DEST_PLIST"

echo "Installed $DEST_SCRIPT and loaded $LABEL from $DEST_PLIST"
