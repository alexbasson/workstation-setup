# Resolve JAVA_HOME to the highest installed LTS JDK, not a hardcoded version

`languages.sh` sets `JAVA_HOME` by scanning `/usr/libexec/java_home -V` for the highest registered major version where `major % 4 == 1` (OpenJDK's LTS cadence: 17, 21, 25, 29, ...), falling back to 25 if nothing matches.

We found this machine's `.zshrc` hardcoded `java_home -v 25`, and that this had already gone stale: Homebrew's unversioned `openjdk` formula had rolled forward to 27 (a non-LTS release) without anyone updating the script. A hardcoded version requires remembering to bump it by hand every ~2 years when a new LTS ships; the `% 4 == 1` rule self-updates as long as the new `openjdk@NN` formula is added to the Brewfile, at the cost of being a less obvious piece of shell than a literal version number.
