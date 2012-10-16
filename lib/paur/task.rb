require 'rake'
require 'rake/tasklib'

module Paur
  class Task < Rake::TaskLib
    include Rake::DSL if defined?(Rake::DSL)

    attr_reader :name

    def initialize(*args)
      @name  = args.shift || :upload

      # TODO: more configuration
      yield self if block_given?

      desc "Upload sources as an AUR package" unless Rake.application.last_comment
      task name do
        RakeFileUtils.send(:verbose, verbose) do
          options  = []
          options << '--verbose' if verbose

          unless system('paur', *options)
            raise "paur returned non-zero: #{$?}"
          end
        end
      end
    end
  end
end
