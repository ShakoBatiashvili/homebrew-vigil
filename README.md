# homebrew-vigil

Homebrew tap for [Vigil](https://github.com/ShakoBatiashvili/vigil), a small menu-bar app and CLI that keeps your
Mac awake, safely: no root, no network, no auto-update, no third-party code.

```sh
brew install ShakoBatiashvili/vigil/vigil
cp -R "$(brew --prefix vigil)/Vigil.app" ~/Applications/
open ~/Applications/Vigil.app
```

The formula **builds Vigil from a tagged source release on your Mac** (it needs Xcode 16 or later and takes about a
minute). There is no prebuilt binary: nothing to trust but the source, and a locally built app opens without
Gatekeeper prompts. The `vigil` command is installed on your `PATH`; the app is built into the Homebrew prefix, so
copy it to `~/Applications` as shown (and again after each `brew upgrade vigil`).

## About trust

Homebrew taps run Ruby code with your privileges, so Homebrew asks you to trust non-official taps. Installing the
fully qualified name above trusts **only this formula**, not the whole tap. Before installing you can read it:

```sh
brew cat ShakoBatiashvili/vigil/vigil
```

The formula pins the SHA-256 of the release tarball. To regenerate that tarball from the source tag yourself:

```sh
git clone https://github.com/ShakoBatiashvili/vigil.git && cd vigil
git archive --format=tar.gz --prefix=vigil-0.1.1/ -o vigil-0.1.1.tar.gz v0.1.1
shasum -a 256 vigil-0.1.1.tar.gz     # should match the formula
```

## Uninstall

```sh
brew uninstall vigil && brew untap ShakoBatiashvili/vigil
rm -rf ~/Applications/Vigil.app
```

License: MIT, see [LICENSE](LICENSE).
