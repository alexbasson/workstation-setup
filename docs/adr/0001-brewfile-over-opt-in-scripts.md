# Use a single Brewfile instead of per-category opt-in bash scripts

This repo used to split package installs across `scripts/common/*.sh` (always run) and `scripts/opt-in/*.sh` (only run if named as a `./setup.sh` argument), because it served many people with different job functions on one team. Now that it only has to describe this one machine, that per-person customization has no reason to exist: everything in the Brewfile installs every time. All formulas/casks/taps moved into one root `Brewfile`, installed via `brew bundle install`; `setup.sh` no longer takes arguments at all.

**Consequence:** anything genuinely optional (e.g. `spring-boot`, kept installed despite being unused today) has to be removed by hand from the Brewfile rather than just omitted from a command-line invocation.
