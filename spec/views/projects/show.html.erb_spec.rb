require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "Name",
      :status => "Status",
      :location => "Location",
      :type => "Type",
      :initiative => "Initiative"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Status/)
    rendered.should match(/Location/)
    rendered.should match(/Type/)
    rendered.should match(/Initiative/)
  end
end
