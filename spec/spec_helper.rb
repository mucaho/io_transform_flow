# frozen_string_literal: true

require "parser"
require "rspec"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec::Matchers.define_negated_matcher :not_be_nil, :be_nil

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true

    mocks.verify_partial_doubles = true

    # Uncomment if needing to mock dynamic classes that use method_missing
    # mocks.before_verifying_doubles do |reference|
    #   reference.target.define_attribute_methods
    # end
  end
end
