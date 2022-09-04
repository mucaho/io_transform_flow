# frozen_string_literal: true

require_relative "io_transform_flow/version"
require_relative "io_transform_flow/domain"
require_relative "io_transform_flow/impl"
require_relative "io_transform_flow/cli"

# Root namespace module for the library.
module IOTransformFlow
  # class Error < StandardError; end
end

IOTransformFlow::CLI.parse! if __FILE__ == $PROGRAM_NAME
