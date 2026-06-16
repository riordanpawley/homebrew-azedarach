class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.14.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/az-darwin-arm64"
      sha256 "e91f0c509bfe90587a072d8255c745e7afa6a45a5e778f3dcada6798605ed5f0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/azd-darwin-arm64"
        sha256 "1eac391caf02f59706ce23d18a507185ba04d650b0ec171d28a6ecd9631acd22"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/az-darwin-x64"
      sha256 "822e5dce54806fdd6e1d415804c1c7165309fe6f319174cd5e926636fb25cdf7"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/azd-darwin-x64"
        sha256 "b0f3b40587474ebed3a468d733432c6c1c89f099e61fbce77674578b430d321a"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/az-linux-x64"
      sha256 "c5d3f064524b236b5d36dc1c872a2e8f3ae71d679a2bfe6dcb422b33a60cdfe5"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.14.0/azd-linux-x64"
        sha256 "519c8380e5290ef39609431498ed90a59a150b3fe3a583446ff922e506a59469"
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
