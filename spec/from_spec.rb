require 'dirge'
require ~'spec_helper'

describe Anybase, "from" do
  it "should translate to a number" do
    Anybase.new("012345678").to_i('2350').should == 1746
  end

  it "should raise an exception if any char isn't included" do
    proc { Anybase.new("012345678").to_i('a2350') }.should raise_error(Anybase::UnrecognizedCharacterError)
  end

  it "should fold case" do
    base = Anybase.new("012345678abcd", :ignore_case => true)
    str = 'a23D5d0AbBc'
    base.to_i(str).should == base.to_i(str.swapcase)
  end

  it "should use synonymous" do
    Anybase.new("012345678", :synonyms => {'0' => 'oO'}).to_i('O235o').should == 1746
    proc { Anybase.new("012345678", :synonyms => {'0' => 'o'}).to_i('235O') }.should raise_error(Anybase::UnrecognizedCharacterError)
  end

  it "should use synonymous & ignore case" do
    Anybase.new("012345678", :synonyms => {'0' => 'o'}, :ignore_case => true).to_i('235O').should == 1746
  end

end
