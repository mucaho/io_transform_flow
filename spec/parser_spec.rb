# frozen_string_literal: true

require "rspec"

RSpec.describe Parser do
  it "has a version number" do
    expect(Parser::VERSION).not_to be_nil
  end
end
