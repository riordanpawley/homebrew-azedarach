class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.17.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/az-darwin-arm64"
      sha256 "fb94b70a887a4c434376e7672dd87a88f875d56a3c12d5f9d55c72443502e2ab"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/azd-darwin-arm64"
        sha256 "73ff8980bc3ee64d28ef1914f94afc5c677d1905868ce6ce292af64e9b5f4a39"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/az-darwin-x64"
      sha256 "8c3515676ab1aca2ecdd1fd37a58f57fa40f665f5d378074309526a3d9e812be"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/azd-darwin-x64"
        sha256 "8405a960c83b3cd5961e8b7c85be974b59c5a5797be28590d194bfaf9f550af4"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/az-linux-x64"
      sha256 "09a976be8dc7ee360139d74d0603d2f573fbf80b46f2779ea0b11754f617e881"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.17.0/azd-linux-x64"
        sha256 "d089499e90da4479d074132c6357345089cc235ff0ba6656dead85309b6d55ce"
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
