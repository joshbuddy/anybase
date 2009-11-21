require 'dirge'
require ~'spec_helper'

describe Anybase, "to" do
  it "should translate base to a number from a string " do
    Anybase.new("012345678").to_native(1827).should == "2450"
  end
end
