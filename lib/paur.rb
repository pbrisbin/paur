module Paur
  class Main
    class << self
      attr_reader :verbose

      def run(argv)
        @verbose = argv.include?('--verbose')

        execute('makepkg -g >> ./PKGBUILD')
        execute("#{ENV['EDITOR']} ./PKGBUILD")
        execute('makepkg --source')

        taurball = Dir.glob('*.src.tar.gz')
        puts "Uploading #{taurball}"
      end

      private

      def execute(cmd)
        puts cmd if verbose

        unless system(cmd)
          raise "#{cmd}: non-zero exit (#{$?}), aborting."
        end
      end
    end
  end
end
