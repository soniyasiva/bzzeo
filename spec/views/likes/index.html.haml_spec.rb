require 'rails_helper'

RSpec.describe "likes/index", type: :view do
  before(:each) do
    assign(:likes, [
      create(:like),
      create(:like)
    ])
  end

  it "renders a list of likes" do
    render
    assert_select "tr>td", :text => /First Exit Media/, :count => 2
    assert_select "tr>td", :text => /This is a really good post description/, :count => 2
  end
end
