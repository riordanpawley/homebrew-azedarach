class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.4.2"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.2/az-darwin-arm64"
      sha256 "edc1e201c0aa05c002adf099bc9ceb0a14a7445d3dc258bd1125053e7bf4068f"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.2/az-darwin-x64"
      sha256 "cc0ef5be0ac4209a61bee0df66e7af436f96302b0dd3bc90d5b6ab49fe8ef2f4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.2/az-linux-x64"
      sha256 "6aeaa00544fde46b0f293e23ffc6b742474e59423aa56ccb2600c23b64326bff"
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
