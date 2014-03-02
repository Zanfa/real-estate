require 'spec_helper'

describe "listings/index" do
  before(:each) do
    assign(:listings, [
      stub_model(Listing,
        :title => "Title",
        :pictures => "Pictures",
        :price => "Price"
      ),
      stub_model(Listing,
        :title => "Title",
        :pictures => "Pictures",
        :price => "Price"
      )
    ])
  end

  it "renders a list of listings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # assert_select "tr>td", :text => "Pictures".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
  end
end
