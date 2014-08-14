# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'templatar/version'

Gem::Specification.new do |spec|
  spec.name          = "templatar"
  spec.version       = Templatar::VERSION
  spec.authors       = ["Andrea Salicetti"]
  spec.email         = ["andrea.salicetti@gmail.com"]
  spec.summary       = %q{Template object for ActiveRecord.}
  spec.description   = %q{A gem that adds an handful singleton to your AR model that responds to every column getter
                          with the name of the column, followed by '_TEMPLATE'.}
  spec.homepage      = "http://www.andreasalicetti.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "supermodel"
end
