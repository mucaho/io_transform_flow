# frozen_string_literal: true

require "rspec"
require_relative "../../../lib/io_transform_flow/domain"

RSpec.describe IOTransformFlow::Domain::Process do
  include_examples "a process", described_class
end
