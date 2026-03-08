class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel Claude Code sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "0.3.7"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.7/az-darwin-arm64"
      sha256 "5d637a651a843ac685dc158b21fd53a2e946d303ed491b32dd2d71e078805a9e"
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.7/az-darwin-x64"
      sha256 "070be21cb67f1feafe2bad117bf5dda8fa7d892ab8ec26122580a4847e58b7f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v0.3.7/az-linux-x64"
      sha256 "e87d4dbbcfc26d48183f129901f5ab58f88d56599709afb618e53ad859a5e25e"
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
