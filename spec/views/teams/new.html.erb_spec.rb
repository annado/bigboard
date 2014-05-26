require 'spec_helper'

describe "teams/new" do
  before(:each) do
    assign(:team, stub_model(Team,
      :name => "MyString",
      :color => "MyString"
    ).as_new_record)
    @board = assign(:board, stub_model(Board,
      :id => 1
    ))
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", board_teams_path(@board), "post" do
      assert_select "input#team_name[name=?]", "team[name]"
      assert_select "input#team_color[name=?]", "team[color]"
    end
  end
end
