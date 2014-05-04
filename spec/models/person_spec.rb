require 'spec_helper'

describe Person do
  it "should require a name" do
    Person.new(:name => "", :uid => "123").should_not be_valid
  end
end
