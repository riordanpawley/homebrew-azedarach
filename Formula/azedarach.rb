class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.0.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/az-darwin-arm64"
      sha256 "a49f3683b279d2ffb9334de49da9e8b77a9d1f87ad36a825c52d74ca36158e27"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/azd-darwin-arm64"
        sha256 "47c3a3fc74fd7b3a028f6ebbf5e5101d321d62419f90179c755264a6e5d03d96"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/az-darwin-x64"
      sha256 "a07b78dc387773d322400c525df9cabcf74ba4bd6418481e5c69c0c4f8c7d354"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/azd-darwin-x64"
        sha256 "4862dcf1d2d57024bdb71d3abfe6fc4df155dcb36cea047b22a8f9316498f8e7"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/az-linux-x64"
      sha256 "349713a846e440d55d4538d9b2ee9230728f2db7687d40c81c55e1142fa01a3d"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.1/azd-linux-x64"
        sha256 "6960147b7de2d3d4d779cf7a63915446bdb999ebd085541e6bee80ba443b1f37"
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
