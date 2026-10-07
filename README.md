# Workstation Setup

A personal, single-machine Mac setup tool. It automates getting this machine into its expected state using simple [Bash](https://www.gnu.org/software/bash/) scripting and a [Homebrew Bundle](https://docs.brew.sh/Brewfile) (`Brewfile`).

This is a fork of [pivotal/workstation-setup](https://github.com/pivotal/workstation-setup), a team-wide onboarding tool. It's no longer meant to serve anyone but me, so it's pared down to exactly what I actually use, with no opt-in/job-function configuration options.

## Why did we do it this way?

 * A bash script is easy to edit locally on-the-fly for small temporary tweaks
 * Everything is in one repository
 * One `Brewfile` is the single source of truth for every formula, cask, and tap
 * It has limited requirements: `git`, `bash`, and Homebrew

## Preparation

- Run the latest version of macOS unless there's a specific reason not to
- Install the latest stable version of [Command Line Tools for Xcode](https://developer.apple.com/download/all/?q=Command%20Line%20Tools%20for%20Xcode)

## Getting this tool

Clone this repository and `cd` into it:

```sh
mkdir -p ~/workspace &&
  cd ~/workspace &&
  git clone <this repo's URL> workstation-setup &&
  cd workstation-setup
```

(`git remote -v` currently still points at the upstream `pivotal/workstation-setup` this was forked from — worth pointing `origin` at your own remote if you want to push changes.)

## Using this tool

Within `~/workspace/workstation-setup`, run:

```shell
./setup.sh
```

**Warning: this tool might overwrite existing configurations.**

Everything it installs lives in `Brewfile` (one flat list, no opt-ins). `setup.sh` sources each script in `scripts/common/` in order; feel free to read or edit any of them.

## Having problems?

If you see errors from `brew`, try running `brew doctor`.

## Frequently Asked Questions and Troubleshooting

_Q: Can I rerun `setup.sh`?_

A: Yes. The scripts are written to be idempotent — reruns shouldn't duplicate shell config or error on already-installed packages.

_Q: Should I run this with `sudo`?_

A: No. `setup.sh` will ask for your password and take care of that itself (needed for JDK symlinking into `/Library/Java/JavaVirtualMachines`).

_Q: I'm getting permission errors such as the one below:_
```sh
Error: Can't create update lock in /usr/local/var/homebrew/locks!
Fix permissions by running:
  sudo chown -R $(whoami) /usr/local/var/homebrew
```
A: **Short answer:** run the suggested command, or consider the **Possible Solution** described below.

**Longer answer:** you might have multiple user profiles on this machine using Homebrew, resulting in a mix of file and directory ownership under `/usr/local/var/homebrew` (or `/opt/homebrew` on Apple Silicon). This should mostly be an issue with installing things, not using the tools installed by `brew`.

**Possible Solution:**

1. Note the default `umask` for later: `umask`
2. Make Homebrew's directories writable by everyone in the `staff` group:
   ```shell
   umask 002
   sudo chmod -R g+w /opt/homebrew/*
   sudo chgrp -R staff /opt/homebrew/*
   ```
3. Set `umask` back: `umask 022` (or whatever was noted earlier)
