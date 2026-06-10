class Vortix < Formula
  desc "Terminal UI for WireGuard and OpenVPN with real-time telemetry and leak guarding"
  homepage "https://docs.rs/vortix"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.4.0/vortix-aarch64-apple-darwin.tar.xz"
      sha256 "b8a462cf9b9bca89b28ee794de792c685a92729add18de06bf741c3ed60de031"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.4.0/vortix-x86_64-apple-darwin.tar.xz"
      sha256 "857b3fd24cc8c9cad211b079b08cfdd24fc10c36af46972c6c8daa7fc2e14434"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.4.0/vortix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04e3e3c729519dc33c2df93cd0902506af31bcaa45de96a17b429dc33fae4c1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/vortix/releases/download/v0.4.0/vortix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ddf78355defd208ce4b6d28e9979c1301088567219cfec3dceed6123a434d0f2"
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
