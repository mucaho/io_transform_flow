# frozen_string_literal: true

require_relative "../lib/parser/domain"
require "stringio"

source = StringIO.new("Hello\nWorld!\n")
destination = StringIO.new

Parser::Domain::Process.process!(source, destination, ->(lines) { lines.map(&:chomp).map(&:reverse) })
puts destination.string
