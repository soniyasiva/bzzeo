require 'rails_helper'

RSpec.describe "posts/show", type: :view do

  # before(:each) do
  #   @post = assign(:post, create(:post, :image))
  # end

  it "renders image attributes in <p>" do
    @post = assign(:post, create(:post, :image))
    render
    expect(rendered).to match(/600x400/)
    expect(rendered).to match(//)
    expect(rendered).to match(/This is a really good post description/)
    expect(rendered).to match(/First Exit Media/)
  end

  it "renders video attributes in <p>" do
    @post = assign(:post, create(:post, :video))
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/-9dAhOsyXBk/)
    expect(rendered).to match(/This is a really good post description/)
    expect(rendered).to match(/First Exit Media/)
  end
end
