class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.3.0.tar.gz"
  sha256 "5ebc4a816ecc0d3777ec0882b05f6a08f6b29f2389471ce3e891ebadb292cbf2"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d1411788de9f7b2cfb8eb86b0d90677269b9d4cc1c1a0b2b7bf2918939208655"
    sha256 cellar: :any_skip_relocation, big_sur:        "e6ed75719455a7cef0976ca2a8e09f784e76b063605a6011f962eb4a2007eb94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7a07aa0cc0fb8f53e7f18a62f3a21e773197360dc815f87973456c622892672"
  end

  depends_on "rust" => :build
  depends_on "teleport"

  def install
    system "cargo", "install", *std_cargo_args

    bash_output = Utils.safe_popen_read(bin/"beam", "completions", "bash")
    (bash_completion/"beam").write bash_output
    zsh_output = Utils.safe_popen_read(bin/"beam", "completions", "zsh")
    (zsh_completion/"_beam").write zsh_output
    fish_output = Utils.safe_popen_read(bin/"beam", "completions", "fish")
    (fish_completion/"beam.fish").write fish_output
  end

  test do
    output = shell_output("#{bin}/beam logout")
    assert_match "You are not logged in with any proxy", output
  end
end
