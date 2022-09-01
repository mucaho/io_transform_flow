# frozen_string_literal: true

require "rspec"
require_relative "../../../lib/parser/domain"

RSpec.describe Parser::Domain::Process do
  include_examples "a process", described_class
end
