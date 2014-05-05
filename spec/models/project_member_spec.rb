require 'spec_helper'

describe ProjectMember do
  it "should belong to a project" do
    ProjectMember.new(:project_id => "").should_not be_valid
  end
end
