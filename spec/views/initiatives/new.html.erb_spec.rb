require 'spec_helper'

describe "initiatives/new" do
  before(:each) do
    assign(:initiative, stub_model(Initiative,
      :name => "MyString",
      :manager_id => 1,
      :analyst_id => 1,
      :owner_id => 1
    ).as_new_record)
  end

  it "renders new initiative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", initiatives_path, "post" do
      assert_select "input#initiative_name[name=?]", "initiative[name]"
      assert_select "input#initiative_manager_id[name=?]", "initiative[manager_id]"
      assert_select "input#initiative_analyst_id[name=?]", "initiative[analyst_id]"
      assert_select "input#initiative_owner_id[name=?]", "initiative[owner_id]"
    end
  end
end
