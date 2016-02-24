require 'rails_helper'

RSpec.describe "post_categories/edit", type: :view do
  before(:each) do
    @post_category = assign(:post_category, PostCategory.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit post_category form" do
    render

    assert_select "form[action=?][method=?]", post_category_path(@post_category), "post" do

      assert_select "input#post_category_name[name=?]", "post_category[name]"
    end
  end
end
