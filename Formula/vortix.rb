class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.2/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "0787778e77c56e560dc9272f3448ce621337051392a4ef9f777196c916dfe231"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.2/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "8ece5c8fe8b37c73fe9b6db13e7aef90e60ac2dba78c15b2685bf8089c97d7fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.2/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bce8c3281089e15a5274649b0f97890525b21c304406ca35cdfc7e0c10840083"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.5.2/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4e9145e80fea37ad492abc7392011dcbb8e6789c2ab8ba8b546ef8fa3f88cbaf"
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
