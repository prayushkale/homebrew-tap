class Chillax < Formula
  desc "Chillax: run an AI product-development company from your terminal"
  homepage "https://chillax.prayush.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/prayushkale/chillax-app/releases/download/v0.1.0/chillax-aarch64-apple-darwin.tar.xz"
      sha256 "bc3bfd8549a8b0a38cc229d4721eefc486c767285df98e77c7f6d3cc58f71b8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/prayushkale/chillax-app/releases/download/v0.1.0/chillax-x86_64-apple-darwin.tar.xz"
      sha256 "9d4d31b0f17f0972e6c221d20990365ba6538e9dfb17c331d2c7d560838d6ac7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/prayushkale/chillax-app/releases/download/v0.1.0/chillax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b9187c2d8a67069d63fa37cbda0fbeec7d21ae5f3e69ecbdb4b6fa2361f3356"
    end
    if Hardware::CPU.intel?
      url "https://github.com/prayushkale/chillax-app/releases/download/v0.1.0/chillax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b548097f54698b7e86fc4ddabdb7d3487fa7fa9fc67f2bf46f33d76311cd61d6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "chillax"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "chillax"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "chillax"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "chillax"
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
