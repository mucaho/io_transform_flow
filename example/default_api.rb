# frozen_string_literal: true

require_relative "../lib/io_transform_flow/domain"
require_relative "../lib/io_transform_flow/impl"
require "stringio"

source = StringIO.new("/about\n/home\n/home\n")
destination = StringIO.new

IOTransformFlow::Domain::Process.process!(source, destination, IOTransformFlow::Impl::CountURIsPipe)
puts destination.string
