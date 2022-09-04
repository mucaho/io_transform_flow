# frozen_string_literal: true

require_relative "../lib/io_transform_flow/domain"
require "stringio"

source = StringIO.new("Hello\nWorld!\n")
destination = StringIO.new

IOTransformFlow::Domain::Process.process!(source, destination, ->(lines) { lines.map(&:chomp).map(&:reverse) })
puts destination.string
