require 'spec_helper'

describe "project_members/index" do
  before(:each) do
    assign(:project_members, [
      stub_model(ProjectMember),
      stub_model(ProjectMember)
    ])
  end

  it "renders a list of project_members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
