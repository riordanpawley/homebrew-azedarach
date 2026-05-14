class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.5.0"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/az-darwin-arm64"
      sha256 "a70713584649ebbdaeca68e545a99fec479abe717c18068f77c633ff0679691f"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/azd-darwin-arm64"
        sha256 "e28ea80197a955c629e5b89e45b76c58867f66496a8f97860f61c15d3cef3d3c"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/az-darwin-x64"
      sha256 "4ff4f2c587caad1e2276d97f1986951a5e35f48eba8142d89290a6d129364e5c"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/azd-darwin-x64"
        sha256 "de858f31c570a8eb042fc7f3717e977e4448b6a7225eb7f01c7523a1831b04e8"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/az-linux-x64"
      sha256 "9c472607ec8161d9afb7313c5142a2ca74183fe1e4f9097ceed36f630c331e1a"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.5.0/azd-linux-x64"
        sha256 "5a2d65839a64d678446565cb8991e932e71a9372e44ed133c2c4209c72c7a68a"
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
