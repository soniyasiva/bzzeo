require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, create(:comment))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Exit Media/)
    expect(rendered).to match(/This is a really good post description/)
    expect(rendered).to match(/Great content/)
  end
end
