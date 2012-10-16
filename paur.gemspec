# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paur/version'

Gem::Specification.new do |gem|
  gem.name          = "paur"
  gem.version       = Paur::VERSION
  gem.authors       = ["Patrick Brisbin"]
  gem.email         = ["pbrisbin@gmail.com"]
  gem.description   = %q{Paur POSTs packages to the AUR.}
  gem.summary       = %q{Paur provies a rake task for uploading your own sofware to the AUR.}
  gem.homepage      = "https://github.com/pbrisbin/paur"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  s.add_runtime_dependency "nokogiri"
end
