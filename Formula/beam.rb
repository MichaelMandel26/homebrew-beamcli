class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "99e5910a9d024a5f32b79443de4b43b0b8a43e643ea793cf2bafb424f9377905"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d44b8726a89af435c6f4ad7fe39f693d648f0a3b8c1e0e516ccfc98d02143f2e"
    sha256 cellar: :any_skip_relocation, big_sur:        "ac058f7d5325d935b882bf6a691cefb24a380f31e72ad23ed93cfd500855050b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ef744d8f9f0e87812591f37ff1fbd65ae38c0b4f331661841953bf365f8ec48"
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
