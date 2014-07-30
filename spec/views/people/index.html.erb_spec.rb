require 'spec_helper'

describe "people/index" do
  before(:each) do
    @board = assign(:board, stub_model(Board,
      :name => "Hello",
      :id => 123,
    ))
    @teams = assign(:teams, [
        stub_model(Team,
        :name => "Team 1",
        :board => @board,
        :color => "#FFF"
      ),
      stub_model(Team,
        :name => "Team 2",
        :board => @board,
        :color => "#FFF"
      )
    ])
    assign(:people, [
      stub_model(Person,
        :name => "Alice",
        :board => @board,
        :team => @teams.first
      ),
      stub_model(Person,
        :name => "Bob",
        :board => @board,
        :team => @teams.last
      )
    ])
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td>a", :text => "Alice".to_s, :count => 1
  end
end
