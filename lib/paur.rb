require 'optparse'
require 'nokogiri'
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

        execute("makepkg -c -g >> ./PKGBUILD")
        execute("#{ENV['EDITOR'] || 'vi'} ./PKGBUILD")
        execute("makepkg --source")

        taurball = Dir.glob('*.src.tar.gz').first
        execute("tar tf '#{taurball}'") if verbose

        cmd  = Submission.new.command_for(taurball, category)
        html = Nokogiri::HTML(`#{cmd}`)

        # if this div is present, there was some error
        pkgoutput = html.css('.pkgoutput')
        if pkgoutput && pkgoutput.any?
          raise "#{pkgoutput.children}"
        end

        puts 'Success.'

      rescue => ex
        $stderr.puts("error: #{ex}")
        $stderr.puts("#{ex.backtrace.join("\n")}") if verbose
        exit 1
      ensure
        if taurball && File.exists?(taurball)
          File.unlink(taurball)
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
