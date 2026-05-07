class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.4.1"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/az-darwin-arm64"
      sha256 "2277557a72c90ea5a246de4b9b612dfbc8ead71b7be327a72770b589be66f2c0"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/azd-darwin-arm64"
        sha256 "f74b65ca3e64d2315613683be09a79061ea1c46c0d021d8e1e8e583c9fbd79c7"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/az-darwin-x64"
      sha256 "0fdc2f1dd454de977aa9d3c7cd4ab767c71cc2227b91bb02d2e71b68408a3ebe"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/azd-darwin-x64"
        sha256 "bdcf498eb09c2340fad693a0c54122e860f2833ff58ae088aff3589fb44c62f2"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/az-linux-x64"
      sha256 "ab1fd0f02f598d7f21a9fdd80c4786dff1fcd8a53b9972e4a46acc67fcf10d9e"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.4.1/azd-linux-x64"
        sha256 "bc53fbe73f30445ffd31f17532676ec34ec11763c958236756cb61fc78e768ab"
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
