class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.6"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.6/az-darwin-arm64"
      sha256 "8e6b9e878fd9ade391484ae9064f1a9487668dee414abc8cea6f6e21c74fea59"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.6/az-darwin-x64"
      sha256 "6cbd740a02b9e6a450c505281404aa274f0f5516202aadf980891e391f6efa53"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.6/az-linux-x64"
      sha256 "99cee8311b7f001832164a624e1d345f295c356caeb74e96cf3e554ef75f5b00"
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
