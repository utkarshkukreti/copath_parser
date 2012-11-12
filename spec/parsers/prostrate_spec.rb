require 'spec_helper'

describe CopathParser::Parsers::Prostrate do
  it "should parse input-1.txt" do
    input = File.read("spec/data/prostrate-input-1.txt")
    output = File.read("spec/data/prostrate-output-1.csv")

    csv = CopathParser::Parsers::Prostrate.parse_to_csv(input)
    csv.should eq(output)
  end
end
