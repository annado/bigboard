require 'spec_helper'

describe "project_members/edit" do
  before(:each) do
    @project_member = assign(:project_member, stub_model(ProjectMember))
  end

  it "renders the edit project_member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_member_path(@project_member), "post" do
    end
  end
end
