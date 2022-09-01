# frozen_string_literal: true

require_relative "domain"

module Parser
  # Namespace module for implementations of abstract domain concepts from the library
  module Impl
    # Example transformation
    module CountURIsPipe
      extend Parser::Domain::Pipe

      # (see Parser::Domain::Pipe#transform)
      #
      # This transformation scans each +String+ line and
      # builds an ordered map between URI paths and their occurence count,
      # with each +String+ entry of the form +URI_path count+,
      # sorted by that count in descending order.
      #
      # It tries to extract a
      # {URI path component}[https://ruby-doc.org/stdlib-2.5.1/libdoc/uri/rdoc/URI.html#method-c-split-label-Synopsis]
      # from the first word encountered in each (conceptual) line.
      # Otherwise, the line is ignored from the result.
      #
      # @param source [#to_enum] object responding to +:to_enum+
      # @return [#to_enum]
      #   an enumeratorable (+:to_enum+) sorted collection of +String+s
      def self.transform(source)
        format_bag(reduce_to_bag(source))
      end

      # @param source [#to_enum]
      # @return [Hash]
      private_class_method def self.reduce_to_bag(source)
        # @param line [String]
        # @param bag [Hash]
        source.to_enum.each_with_object({}) do |line, bag|
          path = extract_path(line)
          if path.nil?
            bag
          else
            bag[path] = (bag[path] || 0) + 1
          end
        end
      end

      # @param line [String]
      # @return [String, nil]
      private_class_method def self.extract_path(line)
        begin
          uri = URI::HTTP.build(path: line.strip.split.first)
        rescue URI::InvalidComponentError, ArgumentError
          uri = nil
        end

        uri&.path
      end

      # @param bag [Hash]
      # @return [#to_enum]
      private_class_method def self.format_bag(bag)
        bag.sort_by { |key, value| [value, key] }
           .reverse!
           .map { |entry| entry.join(" ") }
           .to_enum
      end
    end
  end
end
