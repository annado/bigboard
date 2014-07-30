require 'spec_helper'

describe "locations/new" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123
    ))
    assign(:location, stub_model(Location,
      :name => "MyString",
      :board => nil
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", board_locations_path(@board), "post" do
      assert_select "input#location_name[name=?]", "location[name]"
    end
  end
end
