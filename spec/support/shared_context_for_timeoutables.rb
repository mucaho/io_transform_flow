# frozen_string_literal: true

require "rspec"
require "rspec/expectations"
require "timeout"

RSpec.shared_context "during timeoutable", :timeoutable do
  around do |example|
    Timeout.timeout(3, RSpec::Expectations::ExpectationNotMetError) do
      example.run
    end
  end
end
