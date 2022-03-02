class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.4.0.tar.gz"
  sha256 "073e7d46f7bbaa4a6a9deeb305b313b6b890b0812d3f1e4a9ba2e00d94fa1819"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6596ae6025f4f674c38e0fa32614bb88559047a29927a0adabb5147160079493"
    sha256 cellar: :any_skip_relocation, big_sur:        "43f02ed9128f4bcb7bbfdcbf1170171aa942f80b75c6f2365f14b97eb045496a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f08642edb153d5181fed85cd7ed2ffd5e7b0676727af3f100aaabe19c197036f"
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
