require 'spec_helper'

describe Network do
  it "should require a name" do
    Network.new(:nid => 123, :name => "").should_not be_valid
  end

  it "should require a network id" do
    Network.new(:name => "Test").should_not be_valid
  end

end
