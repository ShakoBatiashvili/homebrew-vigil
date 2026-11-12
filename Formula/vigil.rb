class Vigil < Formula
  desc "Keep your Mac awake, safely: menu-bar app and CLI with a battery guard"
  homepage "https://github.com/ShakoBatiashvili/vigil"
  url "https://github.com/ShakoBatiashvili/vigil/releases/download/v0.1.0/vigil-0.1.0.tar.gz"
  sha256 "7877a69850d8721e1f83ddbdc09c8e5933c87eac64879881049dd80fe548c537"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  def install
    # Homebrew's build sandbox cannot host SwiftPM's own sandbox.
    ENV["SWIFTPM_FLAGS"] = "--disable-sandbox"
    system "scripts/build-app.sh"
    # Install the whole signed bundle, then link the CLI *into* it. `bin.install` would move the helper
    # out of the bundle and break the app's code-signature seal.
    prefix.install "dist/Vigil.app"
    bin.install_symlink prefix/"Vigil.app/Contents/Helpers/vigil"
  end

  def caveats
    <<~EOS
      The menu-bar app was built at:
        #{opt_prefix}/Vigil.app
      Copy it to your Applications folder and open it:
        cp -R "#{opt_prefix}/Vigil.app" ~/Applications/ && open ~/Applications/Vigil.app
      After `brew upgrade vigil`, copy it again to update it.
    EOS
  end

  test do
    assert_match "vigil #{version}", shell_output("#{bin}/vigil version")
    assert_match "USAGE", shell_output("#{bin}/vigil help")
    system "/usr/bin/codesign", "--verify", "--strict", prefix/"Vigil.app"
  end
end
