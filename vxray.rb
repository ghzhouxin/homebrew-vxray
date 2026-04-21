class Vxray < Formula
  desc "Local Xray manager with bundled web UI"
  homepage "https://github.com/ghzhouxin/vxray"
  version "0.1.0"
  license "MIT"

  depends_on "xray"

  on_macos do
    on_arm do
      url "https://github.com/ghzhouxin/vxray/releases/download/v0.1.0/vxray-darwin-arm64.tar.gz"
      sha256 "f9bc99445ecf399b5d94fd2c36cba273cae5af0cf73e0c6ca1e09f39af489a38"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ghzhouxin/vxray/releases/download/v0.1.0/vxray-linux-amd64.tar.gz"
      sha256 "9dfbbfe52870a992c061c754de13486f343908729e648df1ec07c534d9965a51"
    end
  end

  def install
    bin.install "vxray"
    (share/"vxray/web").install Dir["web/*"]
  end

  service do
    run [opt_bin/"vxray"]
    environment_variables(
      VXRAY_HOME: "#{Dir.home}/.vxray",
      VXRAY_WEB_ROOT: "#{opt_prefix}/share/vxray/web",
      VXRAY_XRAY_BINARY: "#{Formula["xray"].opt_bin}/xray"
    )
    keep_alive true
    working_dir Dir.home
  end

  test do
    assert_predicate bin/"vxray", :exist?
    assert_predicate share/"vxray/web/index.html", :exist?
  end
end
