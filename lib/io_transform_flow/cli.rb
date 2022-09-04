# frozen_string_literal: true

require "optparse"
require_relative "domain"
require_relative "impl"

module IOTransformFlow
  # CLI that serves as the entry point of the application, if called from a terminal
  module CLI
    # Extract given command line options and
    # {IOTransformFlow::Domain::Process.process! process!} {ARGF}[https://ruby-doc.org/core-3.1.2/ARGF.html]
    # to {$stdout}[https://docs.ruby-lang.org/en/3.0/globals_rdoc.html] or the given output file
    # @return [void] nothing
    def self.parse!
      options = { output: nil }
      create_parser(options).parse!
      run_parser!(options)
    end

    # @param options [Hash]
    # @return [OptionParser]
    private_class_method def self.create_parser(options)
      OptionParser.new do |parser|
        parser.banner = "Usage: io_transform_flow.rb [options] [file0, [file1, ...]]"
        parser.separator ""
        parser.separator "If no input file(s) are given, input will be read from STDIN."
        parser.separator ""
        parser.separator "Common options:"

        parser.on("-o", "--output file", String, "Specify output file. If omitted, prints to STDOUT.") do |o|
          options[:output] = o
        end

        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit
        end

        parser.on_tail("-v", "--version", "Show version") do
          puts IOTransformFlow::VERSION
          exit
        end
      end
    end

    # @param options [Hash]
    # @return [void]
    private_class_method def self.run_parser!(options)
      # @type [String, nil]
      output = options[:output]

      unless output.nil? || ARGV.none? { |input| File.identical?(input, output) }
        raise ArgumentError, "Cannot output to input file!"
      end

      begin
        original_stdout = $stdout
        $stdout = output.nil? ? $stdout : File.open(output, "w")

        IOTransformFlow::Domain::Process.process!(ARGF, $stdout, IOTransformFlow::Impl::CountURIsPipe)
      ensure
        unless $stdout.equal?(original_stdout)
          redirected_stdout = $stdout
          $stdout = original_stdout
          redirected_stdout.close unless redirected_stdout.closed?
        end
      end
    end
  end
end
