class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/refs/tags/v0.4.6.tar.gz"
  sha256 "aba5d88ed396d7b04e2f2f1c6bbe06dc7a672773747b7e55526fd8fc2720b485"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "af19148f5ae659bfcbecac45106bfa581ec52abee04c6772c9d8bb7dcadf0858"
    sha256 cellar: :any_skip_relocation, big_sur:        "cf4805c306f2d2f859655300d922ff6f759af63401c79bc332bb644dcccaf12a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53deebc277b8fd848b2114e01ee78e3213bd5f43924e1ab4c5031ce74d02b936"
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
