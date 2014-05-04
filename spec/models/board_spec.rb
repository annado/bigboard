require 'spec_helper'

describe Board do
  it "should require a name" do
    Board.new(:name => "").should_not be_valid
  end
end
