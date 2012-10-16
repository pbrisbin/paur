require 'rake'
require 'rake/tasklib'
require 'paur'

module Paur
  class Task < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    attr_reader :name

    def initialize(*args)
      @name  = args.shift || :upload
      config = Config.new

      yield config if block_given?

      desc "Upload sources as an AUR package" unless ::Rake.application.last_comment
      task name do
        RakeFileUtils.send(:verbose, verbose) do
          Main.new.run(config, verbose)
        end
      end
    end
  end
end
