require_relative 'lib/mild/version'

Gem::Specification.new do |spec|
  spec.name          = "mild"
  spec.version       = Mild::VERSION
  spec.authors       = ["Haroon Ahmed"]
  spec.email         = ["haroon.ahmed25@gmail.com"]

  spec.summary       = "GitHub client that helps reviewing pull requests easier"
  spec.homepage      = "https://github.com/hahmed/mild"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hahmed/mild"
  spec.metadata["changelog_uri"] = "https://github.com/hahmed/mild/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
