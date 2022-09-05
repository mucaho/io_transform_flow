# frozen_string_literal: true

require "rspec"
require_relative "../../../lib/io_transform_flow/impl"

RSpec.describe IOTransformFlow::Impl::CountURIsPipe do # rubocop:disable RSpec/FilePath
  include_examples "a pipe", described_class

  context "when transforming data from source to destination" do
    context "if called with invalid inputs" do
      throws = "then it throws an error"

      it "#{throws} given an Enumerator-like input not containing Strings" do
        enumerator = BasicObject.new
        def enumerator.to_enum
          [1, 2, 3].to_enum
        end

        expect { pipe.transform(enumerator) }.to raise_error(NoMethodError)
      end
    end

    context "if it completes successfully" do
      returns = "then it returns an empty Enumerator-like object"

      it "#{returns} given arbitrary String data" do
        result = pipe.transform(%w[a b c])

        expect(result).to contain_exactly
      end

      it "#{returns} given space-separated tokens" do
        result = pipe.transform(["A B", "A B C", "A B C D"])

        expect(result).to contain_exactly
      end

      it "#{returns} given invalid byte sequences in paths" do
        result = pipe.transform(["/SET\355/home/"])

        expect(result).to contain_exactly
      end

      it "#{returns} given invalid URL paths", :aggregate_failures do
        result = pipe.transform(["a"])
        expect(result).to contain_exactly

        result = pipe.transform(["a/"])
        expect(result).to contain_exactly

        result = pipe.transform(["/SETI\\at/home/"])
        expect(result).to contain_exactly
      end

      it "then it returns a non-empty Enumerator-like object given valid URL paths" do
        result = pipe.transform(["/home/"])

        expect(result).to include(a_string_matching(/^.+$/))
      end

      returns = "then it returns a sorted collection containing Strings composed " \
                "of an URL path and its occurrence count"

      it "#{returns}, given a single path in the source line" do
        result = pipe.transform(["/home/"])

        expect(result).to contain_exactly("/home/ 1")
      end

      it "#{returns}, given an untrimmed path in the source line" do
        result = pipe.transform(["   /home/   "])

        expect(result).to contain_exactly("/home/ 1")
      end

      it "#{returns}, given multiple paths in the source line" do
        result = pipe.transform(["/home/   /home/   /home/"])

        expect(result).to contain_exactly("/home/ 1")
      end

      it "#{returns}, given the same path given on multiple source lines" do
        result = pipe.transform(["/home/", "/home/"])

        expect(result).to contain_exactly("/home/ 2")
      end

      it "#{returns}, given multiple different paths across multiple source lines", :aggregate_failures do
        result = pipe.transform(["/c", "/a", "/b", "/a", "/b", "/a"]).to_a

        expect(result.length).to eq(3)
        expect(result[0]).to eq("/a 3")
        expect(result[1]).to eq("/b 2")
        expect(result[2]).to eq("/c 1")
      end
    end
  end
end
