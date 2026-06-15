class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.9.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/az-darwin-arm64"
      sha256 "aeeae6cc2e8087d816893cd144e5832df3e0ff446cdb31560ce06eec2ba1c19c"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/azd-darwin-arm64"
        sha256 "c1a8f9bb87467928edf5237ff85637b5f556456b563eb2787823b52bd2d223c0"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/az-darwin-x64"
      sha256 "d027aa92d3e59cf505d917fd1d9426f18596b25beb33e476bcadd1c3a6a76823"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/azd-darwin-x64"
        sha256 "ab4b4910e01435488a3a7abdeb4d50b61299936176d89296e4be260ad2c71f22"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/az-linux-x64"
      sha256 "1d0c78cbf9a64a6154370fefa547e10ada76bba90b08651132e7701a1d1f75cb"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.9.0/azd-linux-x64"
        sha256 "cf6db04adb53409b9e34370fdd81759d6996232fb61eb745b5e70b63ef9c1ba4"
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
