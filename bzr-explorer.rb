class BzrExplorer < Formula
  desc "Bazaar Explorer - GUI for interacting with Bazaar repositories"
  homepage "https://github.com/fmccann/homebrew-bzr-explorer"
  url "https://github.com/fmccann/homebrew-bzr-explorer/archive/1.0.2.tar.gz"
  sha256 "5034859cba0c9c82a89e1b69d85b2fa682bc3d6c41a8a0ce841bbc995e79a457"

  depends_on "bazaar"
  depends_on "qt"
  depends_on "sip"
  depends_on "pyqt"

  def install
    plugin_dir = "/Users/#{ENV['LOGNAME']}/.bazaar/plugins"
    mkdir_p(plugin_dir)

    if Dir.exist?("#{plugin_dir}/qbzr")
      ohai "Updating bzr-explorer plugin"
      Dir.chdir("#{plugin_dir}/qbzr") do
        system "bzr", "pull"
      end
    else
      ohai "Installing qbzr plugin"
      system "bzr", "branch", "lp:qbzr", "#{plugin_dir}/qbzr"
    end

    if Dir.exist?("#{plugin_dir}/explorer")
      ohai "Updating bzr-explorer plugin"
      Dir.chdir("#{plugin_dir}/explorer") do
        system "bzr", "pull"
      end
    else
      ohai "Installing bzr-explorer plugin"
      system "bzr", "branch", "lp:bzr-explorer", "#{plugin_dir}/explorer"
    end

    bin.install "bzr-explorer"

    puts "\nBazaar Explorer is installed!\n\nInvoke Bazaar Explorer by running 'bzr-explorer'.\n\n"
  end

  test do
  end
end
