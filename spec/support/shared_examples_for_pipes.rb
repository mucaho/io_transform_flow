# frozen_string_literal: true

require "rspec"

RSpec.shared_examples "a pipe" do |subject_pipe|
  subject(:pipe) { subject_pipe }

  it "has a transformation method" do
    expect(pipe).to respond_to(:transform)
  end

  context "when transforming data from source to destination" do
    context "if called with invalid inputs" do
      throws = "then it throws an error"

      it "#{throws} given no input" do
        expect { pipe.transform }.to raise_error(ArgumentError)
      end

      it "#{throws} given too much input" do
        expect { pipe.transform(nil, nil) }.to raise_error(ArgumentError)
      end

      it "#{throws} given invalid input" do
        expect { pipe.transform(nil) }.to raise_error(NoMethodError)
      end
    end

    context "if called with valid inputs" do
      let(:enumerator) do
        out = Object.new
        def out.to_enum(...)
          %w[a b c].to_enum(...)
        end
        out
      end

      it "then it completes successfully given an Enumerator-like object containg Strings" do
        expect { pipe.transform(enumerator) }.not_to raise_error
      end
    end

    context "if it completes successfully" do
      it "then it returns an Enumerator-like object" do
        result = pipe.transform(%w[a b c])

        expect(result).to not_be_nil.and respond_to(:to_enum)
      end
    end
  end
end
