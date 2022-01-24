class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.2.10.tar.gz"
  sha256 "9f5243cd58c9b6243996826d273d2118333133041a106f153550f9ee882ad288"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.2.10"
    sha256 cellar: :any_skip_relocation, big_sur:      "5556ec3ee038d03b50793f29d38b4c9be66cdca1eb08bef03cb7160383df5396"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a404e14bc06a6a8ba78e75e55e092f619bcb5a868839493d39f8019c2e039600"
  end

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
