require 'spec_helper'

describe Anybase, "to" do
  it "should translate base to a number from a string " do
    expect(Anybase.new("012345678").to_native(1827)).to eq("2450")
  end

  it "should never return an empty string for 0" do
    expect(Anybase.new("012345678").to_native(0)).to eq("0")
  end

  it "should normally raise on negative numbers" do
    expect { Anybase.new("012345678").to_native(-10)}.to raise_error(RuntimeError)
  end

  it "should translate negative numbers with a sign" do
    expect(Anybase.new("012345678", :sign => '9').to_native(-10)).to eq('911')
  end

  it "should zeropad" do
    expect(Anybase.new("012345678").to_native(1234, :zero_pad => 2)).to eq('1621')
    expect(Anybase.new("012345678").to_native(1234, :zero_pad => 4)).to eq('1621')
    expect(Anybase.new("012345678").to_native(1234, :zero_pad => 8)).to eq('00001621')
  end

  it "create random numbers" do
    allow(SecureRandom).to receive(:random_number).and_return(5,4,3,2,1,0)
    result = Anybase.new("012345678").random(10)
    expect(result).to eq('5432100000')

    allow(SecureRandom).to receive(:random_number).and_return(0,0,1,2,3,4,5)
    expect(Anybase.new("012345678").random(10, :zero_pad => false)).to eq('12345555')
  end

  it "return a zero if thats all it can for a random number" do
    result = Anybase.new("0").random(10)
    expect(result).to eq('0000000000')

    result = Anybase.new("0").random(10, :zero_pad => false)
    expect(result).to eq('0')
  end

end
