require 'spec_helper'

describe Board do
  it "should require a name" do
    Board.new(:network_id => 1, :name => "").should_not be_valid
  end
end
