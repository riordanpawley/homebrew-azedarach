class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.5"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.5/az-darwin-arm64"
      sha256 "535342c5221051e4318ddacd23630da478b0e75df40553394c845b28177236c9"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.5/az-darwin-x64"
      sha256 "23397928b004814eec00b5061f655bdb0fcfbc4a7d2fbd209ab08d56637bac8e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.5/az-linux-x64"
      sha256 "da7569330b6f508499fb3804a72f9147cbce267a566dbbc3755ecfe280599f22"
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
