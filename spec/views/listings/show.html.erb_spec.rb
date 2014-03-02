require 'spec_helper'

describe "listings/show" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :title => "Title",
      :pictures => "Pictures",
      :price => "Price"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Pictures/)
    rendered.should match(/Price/)
  end
end
