class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.15.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/az-darwin-arm64"
      sha256 "ae8b5f6725cc870800f85a6f80f7ac5157990733655692a70cc7c6566715389d"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/azd-darwin-arm64"
        sha256 "b359eadaaa21925b58aaefc9ccae6584afafcc32da423361385cd207036010e2"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/az-darwin-x64"
      sha256 "67383cf996a7970ae2f36c1c87c432cf5175b93c169d96592ce0ef53ec2636fe"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/azd-darwin-x64"
        sha256 "3b8d9afe8a436dce8d061c39548a997341b7665e879c9476538c82c7efb1070a"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/az-linux-x64"
      sha256 "dfc955e048d63cb90dfc59b235eb215f046469755b2ade4c7e121d29c21ebd7e"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.15.0/azd-linux-x64"
        sha256 "b0f019cd310c9e27d89e1517e443d4272d7bf576debe9badd825839b17a43e33"
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
