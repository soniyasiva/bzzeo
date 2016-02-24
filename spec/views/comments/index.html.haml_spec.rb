require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      create(:comment),
      create(:comment)
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => /First Exit Media/, :count => 2
    assert_select "tr>td", :text => /This is a really good post description/, :count => 2
    assert_select "tr>td", :text => /Great content/, :count => 2
  end
end
