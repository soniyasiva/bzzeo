require 'rails_helper'

RSpec.describe "likes/show", type: :view do
  before(:each) do
    @like = assign(:like, create(:like))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Exit Media/)
    expect(rendered).to match(/This is a really good post description/)
  end
end
