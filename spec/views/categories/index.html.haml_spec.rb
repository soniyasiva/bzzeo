require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      create(:category),
      create(:category)
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", :text => /Real Estate/, :count => 2
  end
end
