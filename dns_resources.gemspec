# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dns_resources/version"

Gem::Specification.new do |spec|
  spec.name          = "dns_resources"
  spec.version       = DnsResources::VERSION
  spec.authors       = ["Anthony J. Ruffa"]
  spec.email         = ["ajosephruffa@gmail.com"]

  spec.summary       = "Simple gem to retrieve DNS resource information."
  spec.description   = "Simple gem to retrieve DNS resource information."
  spec.homepage      = "http://www.github.com/anthonyjruffa/dns_resources"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
