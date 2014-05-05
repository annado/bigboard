require 'spec_helper'

describe "initiatives/index" do
  before(:each) do
    assign(:initiatives, [
      stub_model(Initiative,
        :name => "Name",
        :manager_id => 1,
        :analyst_id => 2,
        :owner_id => 3
      ),
      stub_model(Initiative,
        :name => "Name",
        :manager_id => 1,
        :analyst_id => 2,
        :owner_id => 3
      )
    ])
  end

  it "renders a list of initiatives" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
