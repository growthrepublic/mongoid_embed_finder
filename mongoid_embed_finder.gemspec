# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_embed_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_embed_finder"
  spec.version       = MongoidEmbedFinder::VERSION
  spec.authors       = ["Artur Hebda"]
  spec.email         = ["arturhebda@gmail.com"]
  spec.summary       = %[Find mongoid embedded documents easily.]
  spec.description   = %[
    This simple gem lets you find embedded documents easily. It does not instantiate
    parent record with a whole bunch of embedded documents. Instead it instantiates
    found embedded documents first and then sets parent association.
  ]
  spec.homepage      = "https://github.com/growthrepublic/mongoid_embed_finder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongoid", "~> 4.0.0.beta1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0.0.rc1"
  spec.add_development_dependency "rspec-its", "~> 1.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0.0.rc1"
end