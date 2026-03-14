class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.4.4"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.4/az-darwin-arm64"
      sha256 "76433226ed115527df3ad3507c37a5212cc06ef04b395d6c3891cf4e19c2c712"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.4/az-darwin-x64"
      sha256 "4e9dfbdee50407feeadb01d1022732a151adca292271acac82be09be96c54519"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.4.4/az-linux-x64"
      sha256 "50960c73f94891f2b422ccb125aa1095019ad1331d3a74e1be5cbe0fc39a22f7"
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
