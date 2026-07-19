class Kitz < Formula
  desc "Terminal UI for AWS MSK Kafka with IAM auth, multi-environment switching, and live topic and consumer-group inspection"
  homepage "https://github.com/Harry-kp/kitz"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Harry-kp/kitz/releases/download/v0.1.0/kitz-aarch64-apple-darwin.tar.xz"
      sha256 "643e33d40ed665d61ba74ad5920869954cbba92f524571724f550938b6c1b671"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Harry-kp/kitz/releases/download/v0.1.0/kitz-x86_64-apple-darwin.tar.xz"
      sha256 "50fe5ab98589cc4a501e8cf46f23ba8f4ee488166a2484bfedfc21ca2887c41e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
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
    bin.install "kitz" if OS.mac? && Hardware::CPU.arm?
    bin.install "kitz" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
