require 'spec_helper'

describe "projects/edit" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "MyString",
      :status => "MyString",
      :location => "MyString",
      :type => "",
      :initiative => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_path(@project), "post" do
      assert_select "input#project_name[name=?]", "project[name]"
      assert_select "input#project_status[name=?]", "project[status]"
      assert_select "input#project_location[name=?]", "project[location]"
      assert_select "input#project_type[name=?]", "project[type]"
      assert_select "input#project_initiative[name=?]", "project[initiative]"
    end
  end
end
