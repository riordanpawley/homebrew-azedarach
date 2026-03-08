class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.4"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.4/az-darwin-arm64"
      sha256 "44b3e5f8c97469cf92ef21336443a3a7c30bb155b9d30187cb7145a1972591e7"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.4/az-darwin-x64"
      sha256 "8e0b31cd2318bea6ae0b3f3e4b5280a494bee5380c17fab90d47a061f17c1c69"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.4/az-linux-x64"
      sha256 "ea83e5eedabfc1d5609101047608c8334a98b26fe4f6b40d59f6ceade39df685"
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
