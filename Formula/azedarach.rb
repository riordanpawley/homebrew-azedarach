class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.2.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/az-darwin-arm64"
      sha256 "e2204bf7266f0bcae0b6545625739a7933df2ad43d484714ac7c85adbd69b6b0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/azd-darwin-arm64"
        sha256 "54d3a6b76a2fd3d7795599b7d796e0fef3bbbfc1728673fa22cbb2ec84028065"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/az-darwin-x64"
      sha256 "8316cdcc061c99c5636a1a642a9889301c9daef4dc97773e0d9f019697e3aa3d"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/azd-darwin-x64"
        sha256 "66cad8c631f920673c404154b37323b71619f841d46f76352e6bce2dd112e55e"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/az-linux-x64"
      sha256 "e26cec7e11c1e8260ee09a90f8afdd71d266eedcb57f67d4be971353b5c98fa0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.2.0/azd-linux-x64"
        sha256 "5d1e4b976511f1d83bef791aef9aa7528982c8f955ed7d59d5f7e38ca6931e40"
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
