require 'rails_helper'

RSpec.describe "post_categories/show", type: :view do
  before(:each) do
    @post_category = assign(:post_category, PostCategory.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
