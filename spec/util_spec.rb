require 'spec_helper'

describe Anybase, "util" do
  it "should tell you the size for an arbitrary number of digits" do
    expect(Anybase.new("012345678").size(10)).to eq(3486784401)
    expect(Anybase.new("012345678").size(10) * Anybase.new("012345678").size(10)).to eq(Anybase.new("012345678").size(20))
  end

  it "should normalize a number" do
    expect(Anybase.new("01", :synonyms => {'0' => 'o', '1' => 'l'}, :ignore_case => true).normalize("l10oO1o")).to eq('1100010')
  end

  it "raise if the sign is in the chars" do
    expect{ Anybase.new("01", :sign => '0') }.to raise_error(RuntimeError)
  end

  it "should allow matching" do
    funny_octal = Anybase.new("012345678", :synonyms => {'0' => 'oO'})
    expect(funny_octal.match('235O')).to eq('235O')
    expect(funny_octal.match('235Ozzz')).to eq('235O')
    expect(funny_octal.match('a235O')).to eq(nil)
  end
end
