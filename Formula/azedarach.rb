class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.8.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/az-darwin-arm64"
      sha256 "55453f3235d1c339c6d9f7038c31b140e26fbad83127bb49433312a74ad7eda3"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/azd-darwin-arm64"
        sha256 "dd551dbcc7d56872e55824028048801fcb5fa96347424ac7138acdd1f5d3ef38"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/az-darwin-x64"
      sha256 "a3b013effabb070c97a946325df29babb3eedae3611394375cd38f6240ccb76a"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/azd-darwin-x64"
        sha256 "96859d4d9f620bb44f70c56517962b74a8fd3d84330fe7aaad6d4b8e081df649"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/az-linux-x64"
      sha256 "aee6c73c083129afa885c3570140460333ba7f6fa03fafa26ae72ed47f5b2ca0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.8.0/azd-linux-x64"
        sha256 "e9f72babe29cb02535f784d17232f9d766395f52cbf45a42b963e5a56f440ecc"
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
