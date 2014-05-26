require 'spec_helper'

describe "teams/edit" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :name => "MyString",
      :color => "MyString"
    ))
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123
    ))
  end

  it "renders the edit team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", board_team_path(@board, @team), "post" do
      assert_select "input#team_name[name=?]", "team[name]"
      assert_select "input#team_color[name=?]", "team[color]"
    end
  end
end
