class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.6.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/az-darwin-arm64"
      sha256 "3207c104edeb38cc96e59f5d58458c8218bd53b5a888e7375ef2757dc0f9c7d7"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/azd-darwin-arm64"
        sha256 "6dd0bc80f787a4777bbb843e45b65722ec036dea82d300a35c808df47436cad1"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/az-darwin-x64"
      sha256 "eb499a6c1b6ce8b300beb91ab52aef47ace608ce93b3b035cd5151360155c694"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/azd-darwin-x64"
        sha256 "ca6ddfafbc6b5abd597071a05299e5acd964955903b580742378307edf07a26f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/az-linux-x64"
      sha256 "fb56bf4c2c41b11e4fa2b21a2b881e7763ce388683506edba2a931d976c915c0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.6.0/azd-linux-x64"
        sha256 "2f8883ca22cecfe47467685089132c3c739104aa9b38726bb581efdedd4c753b"
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
