module Paur
  module Utils
    def execute(cmd, verbose = false)
      puts cmd if verbose

      unless system(cmd)
        raise "`#{cmd}': non-zero exit (#{$?}), aborting."
      end
    end
  end
end
