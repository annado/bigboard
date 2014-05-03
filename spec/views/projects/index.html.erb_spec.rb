require 'spec_helper'

describe "projects/index" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :name => "Name",
        :status => "Status",
        :location => "Location",
        :type => "Type",
        :initiative => "Initiative"
      ),
      stub_model(Project,
        :name => "Name",
        :status => "Status",
        :location => "Location",
        :type => "Type",
        :initiative => "Initiative"
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Initiative".to_s, :count => 2
  end
end
