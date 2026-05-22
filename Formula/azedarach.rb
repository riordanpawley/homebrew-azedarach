class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.7.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/az-darwin-arm64"
      sha256 "a272d5a3872bad037591fd7faa7f0b0aecb675898a3e35ae3dfc004e5e01ecd2"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/azd-darwin-arm64"
        sha256 "9b7c308daecf9b0ef1b60cef6518258e0c3f5fa4edeb4bc1cc53247431bd45a2"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/az-darwin-x64"
      sha256 "1fac6df13a50289e1abd5050ce89d4857364f27189462e42f00f07a458e023eb"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/azd-darwin-x64"
        sha256 "5ec3c96ba1741f9989dcccad8859f59da5a1b9adb717f8af861fe0549878d5e0"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/az-linux-x64"
      sha256 "de3ca0754c3575858ca4ebf7d28b9c2dc24e35692ceadde480eb81bcc8f9615d"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.7.0/azd-linux-x64"
        sha256 "30c3b0159dce425bcea831eaa9bbadb66750fa50f233cc08f4dbad371a9a7396"
      end
    end
  end

  def install
    az_binary = Dir["az-*"].first
    raise "Unable to find downloaded az binary" if az_binary.nil?
    bin.install az_binary => "az"
    resource("azd-bin").stage do
      azd_binary = Dir["azd-*"].first
      raise "Unable to find downloaded azd binary" if azd_binary.nil?
      bin.install azd_binary => "azd"
    end
  end

  test do
    assert_match "Usage", shell_output("#{bin}/az --help")
    assert_match "Usage", shell_output("#{bin}/azd --help")
  end
end
