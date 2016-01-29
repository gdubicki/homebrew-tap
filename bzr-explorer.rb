class BzrExplorer < Formula
  desc "Bazaar Explorer - GUI for interacting with Bazaar repositories"
  homepage "https://github.com/fmccann/homebrew-bzr-explorer"
  url "https://github.com/fmccann/homebrew-bzr-explorer/archive/1.0.1.tar.gz"
  sha256 "f2610dde346ca4b05e55cfc11381fdf83896a3ba87d8a5141b0196d1b32947cd"

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
