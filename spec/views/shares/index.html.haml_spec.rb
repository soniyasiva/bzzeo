require 'rails_helper'

RSpec.describe "shares/index", type: :view do
  before(:each) do
    assign(:shares, [
      create(:share),
      create(:share)
    ])
  end

  it "renders a list of shares" do
    render
    assert_select "tr>td", :text => /First Exit Media/, :count => 2
    assert_select "tr>td", :text => /This is a really good post description/, :count => 2
  end
end
