require 'optparse'
require 'fileutils'
require 'paur/submission'

module Paur
  class Main
    class << self
      include FileUtils

      attr_reader :category, :build_dir, :verbose

      def run(argv)
        @category  = 'system'
        @build_dir = '.paur_build'
        @verbose   = false

        OptionParser.new do |o|
          o.banner = 'Usage: paur [options]'
          o.on('-c', '--category CATEGORY')   { |c| @category  = c }
          o.on('-b', '--build-dir DIRECTORY') { |b| @build_dir = b }
          o.on('-v', '--verbose') { @verbose  = true }
        end.parse!(argv)

        execute("BUILD_DIR='#{build_dir}' makepkg -g >> ./PKGBUILD")
        execute("#{ENV['EDITOR']} ./PKGBUILD")
        execute('makepkg --source')

        taurball = Dir.glob("*.src.tar.gz").first
        execute("tar tf '#{taurball}'") if verbose

        s = Submission.new(taurball, category)
        puts(s.submit_command)
        #execute(s.submit_command)

        rm taurball, :verbose => verbose
        rm_rf build_dir, :verbose => verbose

      rescue => ex
        if verbose
          raise ex # explode naturally
        else
          $stderr.puts("#{ex}")
          exit 1
        end
      end

      private

      def execute(cmd)
        puts cmd if verbose

        unless system(cmd)
          raise "#{$?}, command was #{cmd}"
        end
      end
    end
  end
end
