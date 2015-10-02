# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raceresult/version'

Gem::Specification.new do |spec|
  spec.name          = "raceresult"
  spec.version       = RaceResult::VERSION
  spec.authors       = ["Yannick Eckey"]
  spec.email         = ["yannick.eckey@googlemail.com"]

  spec.summary       = %q{Provides a Ruby API for communicating with Race Result timing systems}
  spec.homepage      = "https://github.com/WhyEee/raceresult"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
