class PretAProgram < Formula
  desc "Structured AI-assisted development workflow CLI"
  homepage "https://github.com/brian-lai/PARA-Programming"
  url "https://github.com/brian-lai/PARA-Programming/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "3038e0d087f28ebc614554a83bdc627b286588716253fa14efdcfae5a939bb52"
  license "MIT"

  def install
    # Install the main CLI binary
    bin.install "cli/bin/pret"

    # Install lib (commands + common utilities)
    libexec.install Dir["cli/lib/*"]

    # Install templates and skills to share/
    (share/"pret-a-program/templates").install Dir["cli/lib/templates/*"]
    (share/"pret-a-program/skills").install Dir["skills/*"]

    # Set paths in the pret script so it finds libexec and share
    inreplace bin/"pret" do |s|
      s.gsub! 'PRET_LIBEXEC="${PRET_LIBEXEC:-$SCRIPT_DIR/../lib}"',
              "PRET_LIBEXEC=\"${PRET_LIBEXEC:-#{libexec}}\""
      s.gsub! 'PRET_SHARE="${PRET_SHARE:-$SCRIPT_DIR/..}"',
              "PRET_SHARE=\"${PRET_SHARE:-#{share}/pret-a-program}\""
    end

    # Install shell completions
    bash_completion.install "cli/completions/pret.bash" => "pret"
    zsh_completion.install "cli/completions/pret.zsh" => "_pret"
  end

  test do
    assert_match "pret #{version}", shell_output("#{bin}/pret --version")
    assert_match "Usage:", shell_output("#{bin}/pret --help")
  end
end
