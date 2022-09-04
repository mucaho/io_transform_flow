# frozen_string_literal: true

require "rspec"
require_relative "../../../lib/io_transform_flow/domain"

RSpec.describe IOTransformFlow::Domain::Pipe do
  include_examples "a pipe", described_class
end
