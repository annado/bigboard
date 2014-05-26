require 'spec_helper'

describe "teams/index" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :name => "Name",
        :color => "Color"
      ),
      stub_model(Team,
        :name => "Name",
        :color => "Color"
      )
    ])
    assign(:board, stub_model(Board,
      :id => 123
    ))
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
end
