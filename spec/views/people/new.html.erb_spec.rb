require 'spec_helper'

describe "people/new" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123
    ))
    assign(:teams, [
      stub_model(Team,
        :name => "Team 1",
        :board => @board
      ),
      stub_model(Team,
        :name => "Team 2",
        :board => @board
      )
    ])
    assign(:person, stub_model(Person,
      :name => "MyString",
      :board => @board
    ).as_new_record)
  end

  it "renders new person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", board_people_path(@board), "post" do
      assert_select "input#person_name[name=?]", "person[name]"
    end
  end
end
