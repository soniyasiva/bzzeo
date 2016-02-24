require 'rails_helper'

RSpec.describe "post_categories/new", type: :view do
  before(:each) do
    assign(:post_category, PostCategory.new(
      :name => "MyString"
    ))
  end

  it "renders new post_category form" do
    render

    assert_select "form[action=?][method=?]", post_categories_path, "post" do

      assert_select "input#post_category_name[name=?]", "post_category[name]"
    end
  end
end
