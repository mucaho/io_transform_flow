# frozen_string_literal: true

require_relative "lib/parser/version"

Gem::Specification.new do |spec|
  spec.name = "parser"
  spec.version = Parser::VERSION
  spec.authors = ["mucaho"]
  spec.email = ["mucaho@gmail.com"]

  spec.summary = "Simple parser in ruby for an assignment of performing a reduce operation on a file"
  spec.homepage = "https://github.com/mucaho/simple_ruby_parser"
  spec.license = "MIT"
  spec.required_ruby_version = ">= #{File.read(".ruby-version").split(".").first}"

  spec.metadata["allowed_push_host"] = "https://github.com/"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mucaho/simple_ruby_parser"
  spec.metadata["changelog_uri"] = "https://github.com/mucaho/simple_ruby_parser/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
