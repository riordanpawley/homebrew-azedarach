class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.4.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/az-darwin-arm64"
      sha256 "d1ee89b7e40f67ab5dfe165f2f8f6e3e3b6d6f4b9b68110db91256320d69fa2e"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/azd-darwin-arm64"
        sha256 "da3f0c90b0df911924e6f60a32acd5c93f413d52c2016d5e16c74cc101b1d093"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/az-darwin-x64"
      sha256 "8196e0b72bad114982024fdcbe951ee0aa0b140e71b2a212f3afab3c9205358a"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/azd-darwin-x64"
        sha256 "ee4f953ef7b38f521dfe274eafa06eba416fd8f8d6fae296cd7159896e019797"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/az-linux-x64"
      sha256 "6d44fcb400fa0a1163fbe4c9500e9702aeef31e592da98bb1c7277088bf60ccf"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.0/azd-linux-x64"
        sha256 "a7c4a4162bb4761db57811be7f047fb6dc0a2c45165e864387f105365a781936"
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
