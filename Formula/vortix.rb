class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.6/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "f0b7a132d5908a846333c29ef85c19ea375023495e655d433ce74f9c4492b3c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.6/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "a16ee4ca56d977198136cb64498796fd31c39c54097bac2dc3b3e96c705f08eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.6/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0db5073a89250a8a462d98e82f1a72656a90ef37482ea6d01c74fd649c419b39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.6/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0e66f4e9cbb8d43c6a2cf89aa1411fe2e7864b850b95a9c97fe640308fe0c13c"
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
