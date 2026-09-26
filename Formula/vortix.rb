class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.1/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "11be848f91a20f15a5ef60d9df2daf8c8297aec920f6182a771db6e47f373566"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.1/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "09b155bfdd26effceefe54f92a4665d6134dbb346e685a9bac7bb0a2c73547d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.1/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "054b6f7b0e21bf296cd57e28b6cde2c9a730e7f61e806d0327523747554d0522"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.1/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f0008f4691a60044097e340f6e339e55bfc2c1561cf8b8d996a7ba68efdb0b06"
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
