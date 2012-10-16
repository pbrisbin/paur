require 'optparse'
require 'paur/submission'

module Paur
  class Main
    class << self
      attr_reader :category, :verbose

      def run(argv)
        @category = 'system'
        @verbose  = false

        OptionParser.new do |o|
          o.banner = 'Usage: paur [options]'
          o.on('-c', '--category CATEGORY') { |c| @category = c }
          o.on('-v', '--verbose') { @verbose = true }
        end.parse!(argv)

        execute("makepkg -g >> ./PKGBUILD")
        execute("#{ENV['EDITOR'] || 'vi'} ./PKGBUILD")
        execute("makepkg --source")

        taurball = Dir.glob('*.src.tar.gz').first
        execute("tar tf '#{taurball}'") if verbose

        s = Submission.new(taurball, category)
        puts(s.submit_command)
        #execute(s.submit_command)

        File.unlink(taurball)

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
