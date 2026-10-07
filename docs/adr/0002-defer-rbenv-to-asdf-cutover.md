# Install asdf's ruby plugin without touching the existing rbenv install

Status: superseded by ADR-0004 — the cutover described as a fast-follow here has since been completed.

We decided to standardize Ruby on `asdf` instead of `rbenv`, but `languages.sh` only runs `asdf plugin add ruby` — it does not install a Ruby version, set an asdf global version, or add asdf's shell init to `.zshrc`/`.zprofile`. rbenv's existing shell init lines are left exactly as they are.

This is deliberate: both tools prepend their shim directory to `PATH`, so whichever one's init line runs last in the shell rc wins the `ruby` command. Flipping that silently during an unattended script run — especially without first confirming the target Ruby version builds cleanly via `ruby-build` on this machine — risked breaking whatever currently depends on the rbenv-managed Ruby. The actual cutover (install a Ruby via asdf, set it global, add asdf's shell init, remove rbenv and migrate gems) is intentionally left as a separate, attended step.
