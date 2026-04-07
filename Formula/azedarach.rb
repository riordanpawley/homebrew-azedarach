class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.1.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/az-darwin-arm64"
      sha256 "d513ce9f98106d89354fa59f07d528dd1bc5f24adcee85175300f5a03d0ed0d7"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/azd-darwin-arm64"
        sha256 "90319d145cdcde17944d8f66600d8da996e3b279e4f380055601d567ead98d5c"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/az-darwin-x64"
      sha256 "e0e15b9a0e98d4b3f5b5a2d329449e2f4ac2d05eeb37b63e36e96f7638dbc5bc"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/azd-darwin-x64"
        sha256 "88251acb41b008b0fa35fb3e8532678b37915c8f40399ca530f3c86ff44206ee"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/az-linux-x64"
      sha256 "78e18530ea0094d7b5d11dc5576dc38a1cb85e6e23d7fb8e78d8685e032487df"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.0/azd-linux-x64"
        sha256 "036c7fca402a7f2ff5ee8186dc7cbc3aa0b248514d076dc77b4e928b41df2c8a"
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
