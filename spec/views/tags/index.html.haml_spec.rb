require 'rails_helper'

RSpec.describe "tags/index", type: :view do
  before(:each) do
    assign(:tags, [
      create(:tag),
      create(:tag)
    ])
  end

  it "renders a list of tags" do
    render
    assert_select "tr>td", :text => /Broker/, :count => 2
  end
end
