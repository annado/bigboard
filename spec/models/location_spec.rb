require 'spec_helper'

describe Location do
  before(:each) do
    @attr = { :name => "hello world", :board_id => 123 }
  end

  it "name should be unique" do
    Location.create!(@attr).should be_valid
    Location.new(@attr).should_not be_valid
  end
end
