require 'spec_helper'

describe Anybase, "from" do
  it "should translate to a number" do
    expect(Anybase.new("012345678").to_i('2350')).to eq(1746)
  end

  it "should raise an exception if any char isn't included" do
    expect { Anybase.new("012345678").to_i('a2350') }.to raise_error(Anybase::UnrecognizedCharacterError)
  end

  it "should fold case" do
    base = Anybase.new("012345678abcd", :ignore_case => true)
    str = 'a23D5d0AbBc'
    expect(base.to_i(str)).to eq(base.to_i(str.swapcase))
  end

  it "should translate negative numbers with a sign" do
    expect(Anybase.new("012345678", :sign => '9').to_i('911')).to eq(-10)
  end

  it "should use synonymous" do
    expect(Anybase.new("012345678", :synonyms => {'0' => 'oO'}).to_i('O235o')).to eq(1746)
    expect { Anybase.new("012345678", :synonyms => {'0' => 'o'}).to_i('235O') }.to raise_error(Anybase::UnrecognizedCharacterError)
  end

  it "should use synonymous & ignore case" do
    expect(Anybase.new("012345678", :synonyms => {'0' => 'o'}, :ignore_case => true).to_i('235O')).to eq(1746)
  end

end
