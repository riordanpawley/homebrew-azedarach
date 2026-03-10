class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.4.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.1/az-darwin-arm64"
      sha256 "6272fc77e112df6f1d9cbc623e2f22bd2131deb1348da11ba82536e32e55a9bc"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.1/az-darwin-x64"
      sha256 "b0cb1cfdae3ad0024eed9adb6d3bc95b6c3f48a4b4da326731778b8c55b6cd85"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.1/az-linux-x64"
      sha256 "b9812d6680706713d32f8b07ced3569444a76dcb3ccb87052c2805faac1279de"
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
