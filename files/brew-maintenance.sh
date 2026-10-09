#!/bin/zsh


logdir="$HOME/Library/Logs"
mkdir -p "$logdir"
logfile="$logdir/brewmaintenance.log"


rotate_logs() {
    local max=5


    for ((i=max; i>=2; i--)); do
      if [[ -f "$logfile" ]]; then
        mv "$logfile.$((i-1))" "$logfile.$i"
      fi
    done


    if [[ -f "$logfile" ]]; then
      mv "$logfile" "$logfile.1"
    fi
}

rotate_logs


ts() { /bin/date "+%Y-%m-%d %H:%M"; }

echo "[$(ts)] Starting Homebrew maintenance..." >> "$logfile"

echo "[$(ts)] brew update" >> "$logfile"
/opt/homebrew/bin/brew update >> "$logfile" 2>&1

echo "[$(ts)] brew upgrade" >> "$logfile"
/opt/homebrew/bin/brew upgrade >> "$logfile" 2>&1

echo "[$(ts)] brew cleanup" >> "$logfile"
/opt/homebrew/bin/brew cleanup >> "$logfile" 2>&1

echo "[$(ts)] brew doctor" >> "$logfile"
/opt/homebrew/bin/brew doctor >> "$logfile" 2>&1

echo "[$(ts)] Finished Homebrew maintenance." >> "$logfile"
echo "-----------------------------------------" >> "$logfile"
