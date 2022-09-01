# frozen_string_literal: true

require_relative "parser/version"
require_relative "parser/domain"
require_relative "parser/impl"
require_relative "parser/cli"

# Root namespace module for the library.
module Parser
  # class Error < StandardError; end
end

Parser::CLI.parse! if __FILE__ == $PROGRAM_NAME
