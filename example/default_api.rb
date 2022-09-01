# frozen_string_literal: true

require_relative "../lib/parser/domain"
require_relative "../lib/parser/impl"
require "stringio"

source = StringIO.new("/about\n/home\n/home\n")
destination = StringIO.new

Parser::Domain::Process.process!(source, destination, Parser::Impl::CountURIsPipe)
puts destination.string
