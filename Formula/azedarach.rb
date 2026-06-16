class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.12.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/az-darwin-arm64"
      sha256 "d4c48608276223009d5c46ec46d6b9684bd5c27f93e4b1abdbd878f41ee131cb"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/azd-darwin-arm64"
        sha256 "62a8bc796c53a8f2018a0dc31e944828bc4a6b480ed6174d793eb69f4543723e"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/az-darwin-x64"
      sha256 "bb17446cc0c2a1e563f028f2c6d09563186b4dc1eb8a2ba84e75d36b90671963"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/azd-darwin-x64"
        sha256 "443c6a8034fbd35a863aeff95bcda990b00c2efc41ba058dcb8adc80a40c5fbe"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/az-linux-x64"
      sha256 "f9355a8ae988b4fd3bb6ca2ab0c8678edc81d92947cd985b702f3e2044df91d6"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.12.0/azd-linux-x64"
        sha256 "dfccdc75127a1910df8c5f6e4bc87250f9edf3b8c475be0535d2401f81e0e6f4"
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
