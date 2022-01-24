class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.2.10.tar.gz"
  sha256 "cb417b8bcfa5c7a83aebde412eb121b4a4a289b583cd009a753381e4c6623114"
  license "MIT"

  depends_on "rust" => :build
  depends_on "teleport"
  
  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output("#{bin}/beam logout")
    assert_match "You are not logged in with any proxy", output
  end
end
