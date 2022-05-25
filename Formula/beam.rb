class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "73870c5ee2d5bb2b9e33c296f70fc422afd91eff449be6bf544fcc3e7259864b"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ee38eb17b178889d475f3bae968d5d57e122b10630788417e4cd74ac2d9a5f87"
    sha256 cellar: :any_skip_relocation, big_sur:        "bee254414d35947ab2912315f848b6857a2b1a66568bd7d313f9e17a16fac291"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d8297f06b031ed4c9e32cdd34b18d03d0da2734c29d81d5e97854ca808b265d"
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
