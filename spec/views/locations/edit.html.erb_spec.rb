require 'spec_helper'

describe "locations/edit" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :name => "MyString"
    ))
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123
    ))
  end

  it "renders the edit location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", board_location_path(@board, @location), "post" do
      assert_select "input#location_name[name=?]", "location[name]"
    end
  end
end
