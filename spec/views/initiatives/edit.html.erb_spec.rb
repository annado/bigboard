require 'spec_helper'

describe "initiatives/edit" do
  before(:each) do
    @initiative = assign(:initiative, stub_model(Initiative,
      :name => "MyString",
      :manager_id => 1,
      :analyst_id => 1,
      :owner_id => 1
    ))
  end

  it "renders the edit initiative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", initiative_path(@initiative), "post" do
      assert_select "input#initiative_name[name=?]", "initiative[name]"
      assert_select "input#initiative_manager_id[name=?]", "initiative[manager_id]"
      assert_select "input#initiative_analyst_id[name=?]", "initiative[analyst_id]"
      assert_select "input#initiative_owner_id[name=?]", "initiative[owner_id]"
    end
  end
end
