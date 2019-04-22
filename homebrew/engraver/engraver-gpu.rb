require 'formula'

class Engraver-gpu < Formula
  desc "Burstcoin Reference Plotter"
  homepage "https://burst-coin.org"
  url "https://github.com/PoC-Consortium/engraver/archive/2.20.zip"
  sha256 "4209d787fd6f24bba096d964da618dd45da289d41122288e2a3f50bd8e52de9b"

  depends_on "rust" => :build
  def install
    system "cargo", "build", "--release", "--features=opencl"
    bin.install Dir["target/release/engraver"]
  end
  test do
    system "engraver"
  end
end
