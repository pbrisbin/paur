require 'paur/utils'
require 'paur/aur'
require 'paur/config'
require 'paur/tar'
require 'paur/version'
require 'fileutils'

module Paur
  class Main
    include Utils
    include FileUtils

    def run(config, verbose)
      execute("makepkg -g >> ./PKGBUILD", verbose)
      execute("#{config.editor} ./PKGBUILD", verbose)

      rm_r 'src', :verbose => verbose

      taurball = Tar.new(Dir.pwd, verbose).compress(config.excludes)
      Aur.new(taurball, config.category, verbose).upload
    end
  end
end
