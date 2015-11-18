require 'rails_helper'

RSpec.describe "shares/show", type: :view do
  before(:each) do
    @share = assign(:share, create(:share))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Exit Media/)
    expect(rendered).to match(/This is a really good post description/)
  end
end
