class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.0.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/az-darwin-arm64"
      sha256 "52520d68247e544f7054f6096943b58aedd5f2129d9f7c23161a43efb791e964"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/azd-darwin-arm64"
        sha256 "0445798fc389c0b08624a3b132091ac67f0325f42517547cea2b72407ac52b65"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/az-darwin-x64"
      sha256 "bc3f361922ca9207bdbc7b0b6bc98d1f59e9bb578191e8d9dc19e7e7b57e3c79"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/azd-darwin-x64"
        sha256 "0569cb5f4a8788b26a9fae0a817cd2293c3cbda97da002f4961484f63372855f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/az-linux-x64"
      sha256 "0a5cb8ae5e4c50758849645d6fe8fc7654ffd7bc3627de28b307ac44015990e1"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.0/azd-linux-x64"
        sha256 "50ddbf86639340b11c06f038225af1c51e9be7684f6385365c5ce5aeb31546b9"
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
