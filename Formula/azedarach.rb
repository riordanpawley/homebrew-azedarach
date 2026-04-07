class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.1.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/az-darwin-arm64"
      sha256 "ea8b481de4092245d58abd6b11bfbf4c4a7f9e5bcfc1897190868c5a11550cac"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/azd-darwin-arm64"
        sha256 "49aa483724e9a3cfe824b62974158c4f3515b0ee0155f34561a7b0dfad84c83b"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/az-darwin-x64"
      sha256 "7e0afa0fd8ee0351f252d361591448d911b62c0205126007453d5cc81c46fd2f"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/azd-darwin-x64"
        sha256 "52b156d9afb1441d500d46689bd1fc2393cb12a98eb2fbdb7ea9e0416e16a98a"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/az-linux-x64"
      sha256 "c483072fc67da25f424a12059e601bd83a30d4c3ed0c753562b3de5b6524eeca"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.1.1/azd-linux-x64"
        sha256 "14ea93f24544bf49e9a0b35198c47d53da3714326e45c99b065b65311a79fd5d"
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
