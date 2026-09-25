class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.0/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "aec1ac4edd1095f2cfe5da221a7b7f2c78d0770df9e4097f7c884ae503354575"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.0/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "6a4caddffba309cccb58d657817905d84575b9526ba4edc4c72763bc8d444cc8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.0/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6985f0a155a843f270f1babf9f1bee0d17c07d6d6413486425bf07110b455aee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.0/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e74caa0e549a0396a2f32397f30241220c517ab52fde797a7000a1b3191a470e"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "vortix"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vortix"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vortix"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vortix"
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
