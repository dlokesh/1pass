# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '1pass/version'

Gem::Specification.new do |spec|
  spec.name          = "1pass"
  spec.version       = OnePass::VERSION
  spec.authors       = ["Lokeshwaran"]
  spec.email         = ["dlokesh@gmail.com"]
  spec.description   = "Command line client for AgileBits 1Password"
  spec.summary       = "1pass-#{OnePass::VERSION}"
  spec.homepage      = "https://github.com/dlokesh/1pass"
  spec.license       = "MIT"

  spec.files         = `git ls-files lib/`.split($/)
  spec.executables   = ["1pass"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
