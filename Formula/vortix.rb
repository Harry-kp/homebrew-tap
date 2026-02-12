class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.4/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "f1db03c9887befc7ac82028675896d18c1b4821e648f9a1ab012282373297c66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.4/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "98a230ecb136c666a5cbc9a2558f10881efd8aa69a6cbef39e1ab3ab81e9a8d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.4/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f9ab36d6127aef80f5ff5d0a28763f3c05a2ea2a6d683ca26211c9853e0fb827"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.1.4/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb59e50b3908124678ada3f59880963b01e30ed2542256cdd33c27f3eb343f3c"
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
