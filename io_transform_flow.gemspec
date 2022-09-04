# frozen_string_literal: true

require_relative "lib/io_transform_flow/version"

Gem::Specification.new do |spec|
  spec.name = "io_transform_flow"
  spec.version = IOTransformFlow::VERSION
  spec.authors = ["mucaho"]
  spec.email = ["mucaho@gmail.com"]

  spec.summary = "Simple transform flows between source and destionation IO in Ruby."
  spec.description = "Simple transform flows between source and destination IO in Ruby." \
                     "Exposes an executable binary and an API surface. " \
                     "Default implementation takes logs of URL paths and sorts them by their access count." \
                     "Can be extended to express custom transformations from source to output files."
  spec.homepage = "https://github.com/mucaho/io_transform_flowr"
  spec.license = "MIT"
  spec.required_ruby_version = ">= #{File.read(".ruby-version").split(".").first}"

  spec.metadata["allowed_push_host"] = "https://github.com/"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mucaho/io_transform_flow"
  spec.metadata["changelog_uri"] = "https://github.com/mucaho/io_transform_flow/releases"

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
