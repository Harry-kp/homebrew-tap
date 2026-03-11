class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.7/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "2f1d0bf3e5dbccf858a2b66aabe196f9ee5388adeff5864316a24ab132b49761"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.7/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "c4b992057adf2d3db44b653d838fa4e5d4bb8c7ecbd943603984871420ab0403"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.7/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f73bf7e1c63e53b55c0a1a90ea6af28dbcaadca7a84f201d8fcd6cb188c8849"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.7/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a0abfe7dc165c550f78dd80598b0dd2bdae05f155e9f4642b0a2a253783bd9e"
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
