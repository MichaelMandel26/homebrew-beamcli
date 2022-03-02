class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.4.0.tar.gz"
  sha256 "073e7d46f7bbaa4a6a9deeb305b313b6b890b0812d3f1e4a9ba2e00d94fa1819"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "94238b4a4f26f59ae98fbefeec85af4e8470832f31d5563f9d56832076b5a98d"
    sha256 cellar: :any_skip_relocation, big_sur:        "552ac8bbfb1a993ced1390dfd807da34fcd863aa50b058b78c1af7c1903b08c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d35aea4869e873aa6c43a64baa33c26543f4ebb78fd39bd1399535dfc11e1b1b"
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
