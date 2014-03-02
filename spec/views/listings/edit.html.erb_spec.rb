require 'spec_helper'

describe "listings/edit" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :title => "MyString",
      :pictures => "MyString",
      :price => "MyString"
    ))
  end

  it "renders the edit listing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do
      assert_select "input#listing_title[name=?]", "listing[title]"
      assert_select "input#listing_pictures[name=?]", "listing[pictures]"
      assert_select "input#listing_price[name=?]", "listing[price]"
    end
  end
end
