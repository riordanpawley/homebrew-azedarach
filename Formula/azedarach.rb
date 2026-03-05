class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.1/az-darwin-arm64"
      sha256 "01b7ff3ec81342ac5a7eb54889a3d399283015b083cdd61443dd49072942b55b"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.1/az-darwin-x64"
      sha256 "0b71b4d60f19dd90f0a39d8e9692e905191a7b7e38edb596c2f8732239c47292"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.1/az-linux-x64"
      sha256 "1c26fa253c9c6e7fa2cd4b837ab1bec078e02ef406f4368f65544814f05f668f"
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
