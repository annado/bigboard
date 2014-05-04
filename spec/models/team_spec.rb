require 'spec_helper'

describe Team do
  before(:each) do
    @attr = { :name => "foobar" }
  end

  it "name should be unique" do
    Team.create!(@attr).should be_valid
    Team.new(@attr).should_not be_valid
  end

end
