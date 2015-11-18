require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      create(:post, :image),
      create(:post, :video)
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => /600x400/, :count => 1
    assert_select "tr>td", :text => /-9dAhOsyXBk/, :count => 1
    assert_select "tr>td", :text => "This is a really good post description".to_s, :count => 2
    assert_select "tr>td", :text => "First Exit Media".to_s, :count => 2
  end
end
