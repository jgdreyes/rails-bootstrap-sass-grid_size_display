$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "grid_size_display/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "grid_size_display"
  spec.version     = GridSizeDisplay::VERSION

  spec.authors       = ["jgdreyes"]
  spec.email         = ["jgdreyes@gmail.com"]

  spec.summary       = %q{Display a colored grid size indicator when using bootstrap-sass with Rails.}
  spec.description   = %q{Display a colored grid size indicator when using bootstrap-sass with Rails. Display a colored grid size indicator at the top of the page.  The colors correspond to the bootstrap breakpoints.}
  spec.homepage      = "https://github.com/jgdreyes/grid_size_display"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "rails", "~> 4.2"
  spec.add_dependency "bootstrap-sass", "~> 3.3"
  spec.add_dependency "byebug", "~> 8.2"
end
