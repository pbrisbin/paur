module Paur
  class Tar
    include Utils

    attr_reader :directory, :verbose

    def initialize(directory, verbose = false)
      @directory = directory
      @verbose   = verbose
    end

    def compress(excludes = [])
      filename = filename_from_pkgbuild
      exclude  = excludes.map { |e| "--exclude='#{e}'" }.join(' ')

      options  = 'cpzf'
      options << 'v' if verbose

      Dir.chdir(File.dirname(directory)) do
        execute("tar #{options} #{filename} #{exclude} #{File.basename(directory)}", verbose)
      end

      filename
    end

    private

    def filename_from_pkgbuild
      filename = nil

      File.open('PKGBUILD', 'r') do |fh|
        IO.popen('bash', 'w+') do |ph|
          ph.puts(fh.read)
          ph.puts('name="$pkgname-$pkgver-$pkgrel"')
          ph.puts('echo "/tmp/$name.src.tar.gz"')
          ph.close_write

          filename = ph.read
        end
      end

      filename.chomp
    end
  end
end
