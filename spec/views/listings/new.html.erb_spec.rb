require 'spec_helper'

describe "listings/new" do
  before(:each) do
    assign(:listing, stub_model(Listing,
      :title => "MyString",
      :pictures => "MyString",
      :price => "MyString"
    ).as_new_record)
  end

  it "renders new listing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", listings_path, "post" do
      assert_select "input#listing_title[name=?]", "listing[title]"
      assert_select "input#listing_pictures[name=?]", "listing[pictures]"
      assert_select "input#listing_price[name=?]", "listing[price]"
    end
  end
end
