require 'dirge'
require ~'spec_helper'

describe Anybase, "from" do
  it "should tell you the size for an arbitrary number of digits" do
    Anybase.new("012345678").size(10).should == 3486784401
    (Anybase.new("012345678").size(10) * Anybase.new("012345678").size(10)).should == Anybase.new("012345678").size(20)
  end

end
