# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/trailing_slashes/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-trailing_slashes"
  spec.version       = Rack::TrailingSlashes::VERSION
  spec.authors       = ["Phil Lee"]
  spec.email         = ["asmega@ph-lee.com"]
  spec.summary       = "Rack middleware to handle redirects for trailing slashes"
  spec.description   = "Rack middleware to improve seo by reducing duplicate content from your website"
  spec.homepage      = "https://github.com/asmega/rack-trailing_slashes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 0'
  spec.add_development_dependency "rack-test", '~> 0'
  spec.add_development_dependency "pry", '~> 0'
end
