class Kitz < Formula
  desc "Terminal UI for Kafka and AWS MSK: topics, messages and consumer lag at a glance, with IAM auth and multi-environment switching"
  homepage "https://github.com/Harry-kp/kitz"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/kitz/releases/download/v0.2.0/kitz-aarch64-apple-darwin.tar.xz"
      sha256 "10d72cebc10e117c410f82054e80104fc773418c2c03f2679d8f1e01c1510fe3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/kitz/releases/download/v0.2.0/kitz-x86_64-apple-darwin.tar.xz"
      sha256 "84c6f391b2b563f3652edfc33d25c120769dc748f43a4e1716f8951c240ac26a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Harry-kp/kitz/releases/download/v0.2.0/kitz-x86_64-unknown-linux-musl.tar.xz"
    sha256 "a5a1285e53d18602363414702b27657f25acf3adc9d7be63e0e9cc973b22bea0"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kitz"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kitz"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kitz"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
