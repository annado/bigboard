require 'spec_helper'

describe Role do
  it "should require a name" do
    Role.new(:name => "").should_not be_valid
  end
end
