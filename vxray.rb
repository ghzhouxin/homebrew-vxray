class Vxray < Formula
  desc "Local Xray manager with bundled web UI"
  homepage "https://github.com/ghzhouxin/vxray"
  version "0.2.0"
  license "MIT"

  depends_on "xray"

  on_macos do
    on_arm do
      url "https://github.com/ghzhouxin/vxray/releases/download/v0.2.0/vxray-darwin-arm64.tar.gz"
      sha256 "212b3ce4758b4a963d4bc607b6d7005d8a57c43ddf46cc5d23ebe466281665e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ghzhouxin/vxray/releases/download/v0.2.0/vxray-linux-amd64.tar.gz"
      sha256 "c36ed08289812996aac3e52487cd5b64b94bc7818f78044253fbf7b8b6ab26e7"
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
