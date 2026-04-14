class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.3.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/az-darwin-arm64"
      sha256 "2d08f12fe2a4f091d1a4e22bc81f2aa4049ef477836c8cb639c58c761c3d9292"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/azd-darwin-arm64"
        sha256 "5fbf4191d592bf09bc9a571ea2cf25207bf46092558d801ac9bd4a3e774b0f82"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/az-darwin-x64"
      sha256 "2e7b85cf5ba089e7d049bd2ade365d66a943bcacdd2d744ce5304fa115a7b09b"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/azd-darwin-x64"
        sha256 "212550305d95691c0e31f181f7f53e95f5efc981743062b3a20428f850da3027"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/az-linux-x64"
      sha256 "f187d8191dc3f28684eedfbb2ee0583b58d568a09677f429e567729e8131cd1f"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.3.0/azd-linux-x64"
        sha256 "c8c6a6df4e0f1f7edfeda5b60bde66643163389593d7a94739aca20d165b5cb7"
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
