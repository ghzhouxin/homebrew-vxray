class Vxray < Formula
  desc "Local Xray manager with bundled web UI"
  homepage "https://github.com/ghzhouxin/vxray"
  version "0.2.6"
  license "MIT"
  depends_on "xray"

  on_macos do
    on_arm do
      url "https://github.com/ghzhouxin/vxray/releases/download/v0.2.6/vxray-darwin-arm64.tar.gz"
      sha256 "6c3aadea4370064af65f19433fb6f0102a18b9509f03a275e983a87c07e590eb"
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
      PATH: "#{Dir.home}/.local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin",
    )
    keep_alive true
    working_dir Dir.home
  end

  test do
    assert_predicate bin/"vxray", :exist?
    assert_predicate share/"vxray/web/index.html", :exist?
  end
end
