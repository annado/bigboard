require 'spec_helper'

describe "locations/index" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123
    ))
    assign(:locations, [
        stub_model(Location,
        :name => "Name",
        :board => nil
      ),
      stub_model(Location,
        :name => "Name",
        :board => nil
      )
  ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td>a", :text => "Name".to_s, :count => 2
  end
end
