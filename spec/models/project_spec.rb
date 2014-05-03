require 'spec_helper'

describe Project do
  it "should require a name" do
    Project.new(:name => "").should_not be_valid
  end
end
