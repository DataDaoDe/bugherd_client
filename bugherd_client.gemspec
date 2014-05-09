# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bugherd_client/version'

Gem::Specification.new do |spec|
  spec.name          = "bugherd_client"
  spec.version       = BugherdClient::VERSION::STRING
  spec.authors       = ["John Faucett"]
  spec.email         = ["jwaterfaucett@gmail.com"]
  spec.summary       = %q{Ruby Client for the Bugherd API}
  spec.description   = %q{Ruby Client for the Bugherd Rest API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.6"
  spec.add_dependency "hashie", "~> 2.1"
  spec.add_dependency "activesupport", "> 3.0", "< 5.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rake"
end
