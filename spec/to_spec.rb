require 'dirge'
require ~'spec_helper'

describe Anybase, "to" do
  it "should translate base to a number from a string " do
    Anybase.new("012345678").to_native(1827).should == "2450"
  end

  it "should never return an empty string for 0" do
    Anybase.new("012345678").to_native(0).should == "0"
  end

  it "should raise on negative numbers" do
    proc { Anybase.new("012345678").to_native(-10)}.should raise_error
  end

  it "should zeropad" do
    result = Anybase.new("012345678").to_native(1234, :zero_pad => 8)
    result.size.should == 8
    result.should == '00001621'
  end

  it "create random numbers" do
    srand(10)
    result = Anybase.new("012345678").random(10)
    result.should == '4010180864'

    srand(39)
    Anybase.new("012345678").random(10, :zero_pad => false).should == '463048140'
  end

  it "return a zero if thats all it can for a random number" do
    result = Anybase.new("0").random(10)
    result.should == '0000000000'

    result = Anybase.new("0").random(10, :zero_pad => false)
    result.should == '0'
  end

end
