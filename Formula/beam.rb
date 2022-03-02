class Beam < Formula
  desc "Enhance your teleport workflow with a fuzzy finder interface"
  homepage "https://github.com/MichaelMandel26/beam"
  url "https://github.com/MichaelMandel26/beam/archive/v0.4.1.tar.gz"
  sha256 "09b3d4d3e82e146c040040dcd352e3296fbfa4b25c3fffae431be99b612e2dbc"
  license "MIT"

  bottle do
    root_url "https://github.com/MichaelMandel26/homebrew-beamcli/releases/download/beam-0.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "e437208d87b0cf93e6f65c68e362477972b43322fb4fa5c16ac0d1fc9caa3efa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1127933a61fe4bfc6945396723cbe071d2040ab3924e913881ba096ac85edb67"
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
