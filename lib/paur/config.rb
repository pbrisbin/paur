module Paur
  class Config
    # Your aur username. Default is read from the environment variable
    # AUR_USERNAME (recommended).
    attr_accessor :aur_username

    # Your aur password. Default is read from the environment variable
    # AUR_PASSWORD (recommended).
    attr_accessor :aur_password

    # Numeric category for the package. Default is 16 (System).
    attr_accessor :category

    # Editor used to finalize the PKGBUILD before upload. Default is the
    # environment variable EDITOR.
    attr_accessor :editor

    # Files that will be excluded from the final taurball. Use #exclude
    # to add without overwriting. Default is .git, .gitignore, and
    # README.md.
    attr_accessor :excludes

    def initialize
      @editor       = ENV['EDITOR']
      @aur_username = ENV['AUR_USERNAME']
      @aur_password = ENV['AUR_PASSWORD']
      @category     = 16
      @excludes     = %w[ .git .gitignore README.md ]
    end

    def exclude(file_or_files)
      @excludes += Array(file_or_files)
    end
  end
end
