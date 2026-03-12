class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.4.3"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.3/az-darwin-arm64"
      sha256 "11af373302abbafd97b63185b160c828e06d6453ebd4ad1314e0b1141888c0a0"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.3/az-darwin-x64"
      sha256 "a3a46d111687424e51bf9505af25d1dcb5302abc777bcc7ebc6be4e65073139a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.3/az-linux-x64"
      sha256 "8fae7e7ec73a901a12cf07d37d66992e5a6ea8c67133b098a388ae1524cc8a0e"
    end
  end

  def install
    binary = Dir["az-*"].first
    raise "Unable to find downloaded az binary" if binary.nil?

    bin.install binary => "az"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/az --help")
  end
end
