require 'dirge'
require ~'spec_helper'

describe Anybase, "from" do
  it "should translate to a number" do
    Anybase.new("012345678").to_i('2350').should == 1746
  end

  it "should raise an exception if any char isn't included" do
    proc { Anybase.new("012345678").to_i('a2350') }.should raise_error(Anybase::UnrecognizedCharacterError)
  end

end
