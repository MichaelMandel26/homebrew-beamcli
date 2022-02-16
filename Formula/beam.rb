class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.2.10.tar.gz"
  sha256 "9f5243cd58c9b6243996826d273d2118333133041a106f153550f9ee882ad288"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.2.10"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "41d36e9f41ce51c2a23ee515ac436488882eea3c7ce59b50fb88f1fdff8821e4"
    sha256 cellar: :any_skip_relocation, big_sur:        "daf9b492402a0bfb2928704383c60e5ee9b936319c1c6816989f037e1c40633e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d985b0cfc5a7e8e28aa079b5b5f7445e1bc1fe1cdb8ea4cc92c80b5991168daa"
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
