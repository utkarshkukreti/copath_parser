# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'copath_parser/version'

Gem::Specification.new do |gem|
  gem.name          = "copath_parser"
  gem.version       = CopathParser::VERSION
  gem.authors       = ["Utkarsh Kukreti"]
  gem.email         = ["utkarshkukreti@gmail.com"]
  gem.description   = %q{Copath Parser}
  gem.summary       = %q{Copath Parser}
  gem.homepage      = "https://github.com/utkarshkukreti/copath_parser"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'parslet'
  gem.add_dependency 'docopt'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
