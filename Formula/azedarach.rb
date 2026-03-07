class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.3"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.3/az-darwin-arm64"
      sha256 "5c4f4ceafc21da3a34b42d66d75231bd1f412bcbe523f084088536fccc1316e6"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.3/az-darwin-x64"
      sha256 "51b72bf16c00ddd0f023195289a4f7db7f45ce973573e6d4f3dbd88c287b84f6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.3/az-linux-x64"
      sha256 "3edaba0398d00b291a8b05287386267e2671ca9fc1eefc76a7d6e0c208b5da38"
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
