class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d282325d5d6c347f169bbc1730be4712644cb4c6e05d3f36ccfe9604ba2a84da"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9faef479ccfae01bc250010082530050c3f4684af0feaa4e844f83a2ee38230f"
    sha256 cellar: :any_skip_relocation, big_sur:        "3c99876fd8ffb1c22e537350d080c02bfb5afcfed2a7ded9dbb655f5e164f055"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "19036ba636e43c034b9d4fdf70c1736e58d680335de90a49e915abe8fc626e05"
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
