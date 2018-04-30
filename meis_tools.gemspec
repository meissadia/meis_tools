
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "meis_tools/version"

Gem::Specification.new do |spec|
  spec.name          = "meis"
  spec.version       = Meis::VERSION
  spec.authors       = ["Meissa Dia"]
  spec.email         = ["meissadia@gmail.com"]

  spec.summary       = %q{A collection of helper methods I want to reuse.}
  spec.description   = %q{Helper methods for ruby development.}
  spec.homepage      = "https://github.com/meissadia/"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",  "~> 1.16"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "terminal-table", "~> 1.8.0"

  spec.required_ruby_version = ' >= 1.9.3'
end
