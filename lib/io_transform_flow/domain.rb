# frozen_string_literal: true

require "uri"

module IOTransformFlow
  # Namespace module for domain concepts used in the library
  module Domain
    # Domain module that models the process of transforming things from a source to a destination resource,
    # conceptually line by line.
    module Process
      # Process the given source {IO}[https://ruby-doc.org/core/IO.html] using the given +transform+,
      # by writing the obtained transformation output to given destination
      # {IO}[https://ruby-doc.org/core/IO.html].
      #
      # @param source [#each_line] object responding to +:each_line+
      # @param destination [#puts] object responding to +:puts+
      # @param transform [#to_proc] object responding to +:to_proc+
      # @return [void] nothing
      # @raise [IOError] an {IOError}[https://ruby-doc.org/core/IOError.html] in case something goes wrong
      def self.process!(source, destination, transform)
        transform.to_proc.call(source.each_line.lazy).to_enum.each do |line|
          destination.puts(line)
        end
      end
    end

    # Domain module that models the actual transformation of a {IOTransformFlow::Domain::Process Process}.
    # This module implements the identity {#transform}.
    #
    # Module and stateless Class implementors should extend this module
    # to offer a custom {#transform self.transform} class method implementation.
    # Stateful Class implementors should include this module
    # to offer a custom {#transform transform} instance method implementation.
    module Pipe
      # inherited class methods shall remain public
      extend self # rubocop:disable Style/ModuleFunction

      # Transform an {Enumerator}[https://ruby-doc.org/core/Enumerator.html] to another
      # {Enumerator}[https://ruby-doc.org/core/Enumerator.html].
      #
      # @param source [#to_enum] object responding to +:to_enum+
      # @return [#to_enum] object responding to +:to_enum+
      def transform(source)
        source.to_enum.map(&:itself).to_enum
      end

      # Convert +self+ to a {Proc}[https://ruby-doc.org/core-3.1.2/Proc.html]
      # having the signature of {#transform}.
      #
      # @return [Proc] +self+ as a callable +Proc+
      def to_proc
        method(:transform).to_proc
      end
    end
  end
end
