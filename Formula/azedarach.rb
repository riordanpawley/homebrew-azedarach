class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.16.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/az-darwin-arm64"
      sha256 "453bbd52cd900f394feb46e608a335495f987eda8ee05f259ab0d4ed9f153a87"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/azd-darwin-arm64"
        sha256 "4a188f0e9a1a32f1e489dcda8c61c2c238cdad02372fe39be77eb251480129c7"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/az-darwin-x64"
      sha256 "5ebc8b4ac29bef2609cdcbb82a44d0a860fd23f095b377ec7d8e26562ac35446"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/azd-darwin-x64"
        sha256 "d0059569b5814e98f4fcd3748035394f0d3f0feb12d92b2381f6591b761c831a"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/az-linux-x64"
      sha256 "4188b5357c0447e73c49c3edc9b3bcfcd99c1627f8060812488d4be31e4c3acb"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.16.0/azd-linux-x64"
        sha256 "acfa405f130d57be9834a7f0abf6af1adbbb60206a984cdf47b49ab9fa824c1d"
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
