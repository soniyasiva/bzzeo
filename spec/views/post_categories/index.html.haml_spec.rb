require 'rails_helper'

RSpec.describe "post_categories/index", type: :view do
  before(:each) do
    assign(:post_categories, [
      PostCategory.create!(
        :name => "Name"
      ),
      PostCategory.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of post_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
