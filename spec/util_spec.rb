require 'dirge'
require ~'spec_helper'

describe Anybase, "from" do
  it "should tell you the size for an arbitrary number of digits" do
    Anybase.new("012345678").size(10).should == 3486784401
    (Anybase.new("012345678").size(10) * Anybase.new("012345678").size(10)).should == Anybase.new("012345678").size(20)
  end

  it "should normalize a number" do
    Anybase.new("01", :synonyms => {'0' => 'o', '1' => 'l'}, :ignore_case => true).normalize("l10oO1o").should == '1100010'
  end
end