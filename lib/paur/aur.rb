module Paur
  class Aur
    attr_reader :tar_file, :category, :verbose

    def initialize(tar_file, category, verbose)
      @tar_file = tar_file
      @category = category
      @verbose  = verbose
    end

    def upload

    end
  end
end
