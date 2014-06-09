require 'spec_helper'

describe "project_members/new" do
  before(:each) do
    assign(:project_member, stub_model(ProjectMember).as_new_record)
  end

  it "renders new project_member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_members_path, "post" do
    end
  end
end
