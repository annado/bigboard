require 'spec_helper'

describe Initiative do
  it "should require a name" do
    Initiative.new(:name => "").should_not be_valid
  end
end
