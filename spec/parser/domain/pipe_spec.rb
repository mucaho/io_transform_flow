# frozen_string_literal: true

require "rspec"
require_relative "../../../lib/parser/domain"

RSpec.describe Parser::Domain::Pipe do
  include_examples "a pipe", described_class
end
