class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.4.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.0/az-darwin-arm64"
      sha256 "1c34445e4f6dd3d1a3753d8be082cb8e05784618ea2f3ec2ba3e4ea78b15adc5"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.0/az-darwin-x64"
      sha256 "ae450a6ed8466ef3a65e07d607463bf9219ccfb6b5dc5c56e1ea1c5ae257238f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.0/az-linux-x64"
      sha256 "e42aec86520132ccb56ab84beaefd08b5855f46f8a8b272b73e0196d1585bbac"
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
