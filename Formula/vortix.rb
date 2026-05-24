class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.3.1/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "f27fc4cc64623bd4c4f19b1968ca629470498bd19c9d17e7017bd9158bc1479b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.3.1/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "ac71675793366dd807ce9bb08b7b76df01b63ffbca3a24b8e9368f7491c00815"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.3.1/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a4e52857b8516607a6d29170a3df65d57519fd9d9aef8cb53b343308b2a2b587"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.3.1/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b710bdbd8ef6ad52ba675428b51a42636d4cf8149f3c6ec54a7f5a04bca3aa18"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
    bin.install "vortix" if OS.mac? && Hardware::CPU.arm?
    bin.install "vortix" if OS.mac? && Hardware::CPU.intel?
    bin.install "vortix" if OS.linux? && Hardware::CPU.arm?
    bin.install "vortix" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
