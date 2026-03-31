class Azedarach < Formula
  desc "TUI Kanban board for orchestrating parallel AI sessions"
  homepage "https://github.com/riordanpawley/azedarach"
  version "1.0.2"
  license "MIT"

  conflicts_with "azure-cli", because: "both install an executable named az"

  on_macos do
    on_arm do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/az-darwin-arm64"
      sha256 "fb086356ee9e96ed57041347900897a6cf5119b857ebe50d19772a12e2037299"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/azd-darwin-arm64"
        sha256 "2ef9fceaa5855efe9402726e29841e354b6d55c300b868cadb906a7e8a228490"
      end
    end

    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/az-darwin-x64"
      sha256 "0434720a8b56f80d3ea54c1c0d59f9db3827f1a1bb9abc1d99e257880596554e"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/azd-darwin-x64"
        sha256 "4ef83d9b0b1671d0bd62b3ee66e84c061b3d98b2a42417a7c4b90bec79440bc1"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/az-linux-x64"
      sha256 "ff652de2db9700e15c0f3a1fed672efaccb9b261b04689988f0b356104c518c1"
      resource "azd-bin" do
        url "https://github.com/riordanpawley/azedarach/releases/download/v1.0.2/azd-linux-x64"
        sha256 "a758ff6824aeaf3c590921fccb9fcb998583f0c1e94eff780cd80dddeed01bf2"
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
