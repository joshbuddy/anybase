require 'dirge'
require ~'spec_helper'

describe Anybase, "to" do
  it "should translate base to a number from a string " do
    Anybase.new("012345678").to_native(1827).should == "2450"
  end

  it "should never return an empty string for 0" do
    Anybase.new("012345678").to_native(0).should == "0"
  end

  it "should zeropad" do
    result = Anybase.new("012345678").to_native(1234, :zero_pad => 8)
    result.size.should == 8
    result.should == '00001621'
  end

end
