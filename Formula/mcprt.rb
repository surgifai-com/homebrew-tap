class Mcprt < Formula
  desc "Connection-refcounted MCP server lifecycle manager. Spawn on demand, stop on idle."
  homepage "https://github.com/surgifai-com/mcprt"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/surgifai-com/mcprt/releases/download/v0.1.0/mcprt_0.1.0_darwin_arm64.tar.gz"
      sha256 "5abe0db20cd0de01179023d59ed88d9835c50d029c809dfc5ef903c5bda8365b"
    else
      url "https://github.com/surgifai-com/mcprt/releases/download/v0.1.0/mcprt_0.1.0_darwin_amd64.tar.gz"
      sha256 "daca841b8e409a287dd4347a38b108ab344070c00d308f6d81fa8902fb768a2a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/surgifai-com/mcprt/releases/download/v0.1.0/mcprt_0.1.0_linux_arm64.tar.gz"
      sha256 "a4f226a067c439197eecccbc3130274ebb6779b1b67bf4efa6591a88034c627e"
    else
      url "https://github.com/surgifai-com/mcprt/releases/download/v0.1.0/mcprt_0.1.0_linux_amd64.tar.gz"
      sha256 "9fb35d1951004f7a86e1b181a2e8eb7fdda433b218e48992bd08d42607fc88d9"
    end
  end

  def install
    bin.install "mcprt"
    (share/"mcprt").install "contrib/launchd/com.mcprt.daemon.plist"
  end

  def caveats
    <<~EOS
      To start mcprt as a background service, install the launchd plist:

        cp #{HOMEBREW_PREFIX}/share/mcprt/com.mcprt.daemon.plist ~/Library/LaunchAgents/
        # Edit ~/Library/LaunchAgents/com.mcprt.daemon.plist — replace YOUR_USERNAME
        launchctl load ~/Library/LaunchAgents/com.mcprt.daemon.plist

      Config file: ~/.config/mcprt/mcprt.toml
      Docs: https://github.com/surgifai-com/mcprt
    EOS
  end

  test do
    assert_match "mcprt", shell_output("#{bin}/mcprt --version 2>&1")
  end
end
