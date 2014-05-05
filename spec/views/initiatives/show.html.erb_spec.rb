require 'spec_helper'

describe "initiatives/show" do
  before(:each) do
    @initiative = assign(:initiative, stub_model(Initiative,
      :name => "Name",
      :manager_id => 1,
      :analyst_id => 2,
      :owner_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
