class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.5.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/az-darwin-arm64"
      sha256 "45bb4e552a403d9348d05c877ffc5e639e8a39fc5a16f24b38c30d65e4c5e996"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/azd-darwin-arm64"
        sha256 "7bc336c0e047a57943f977bd6116ca640f674ad1bfc2638f4461520a83958713"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/az-darwin-x64"
      sha256 "878585310a0804ce667b9f34bab0fcfb11f0f899249ddcc36d05a788076595f9"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/azd-darwin-x64"
        sha256 "c8bed9db91369edbf40bad26c9318e5bc51a365413549fc81147c79ea418da47"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/az-linux-x64"
      sha256 "f1a4b5cd17524cdaad6427e999533f956994813a28e6985f26ce3e71d98b2211"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.1/azd-linux-x64"
        sha256 "719cbdfc6210e3bb6fc959edd49c2545afd9bf7a3be924f0f4e076cd3e3b429f"
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
