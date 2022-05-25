class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "73870c5ee2d5bb2b9e33c296f70fc422afd91eff449be6bf544fcc3e7259864b"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "798f85a48d8d92be82188046aeebad6e903033e3f09b01c17871d4fb18c2c164"
    sha256 cellar: :any_skip_relocation, big_sur:        "8b29fd2a064f042267f61569a0a27280767fcec750f77472248976f23a8239f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c2bd1149060b8ddec707b9febd902b3cc6804569b5cef6f2bfee37890e30275"
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
