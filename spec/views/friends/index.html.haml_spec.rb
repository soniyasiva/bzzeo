require 'rails_helper'

RSpec.describe "friends/index", type: :view do
  before(:each) do
    assign(:friends, [
      Friend.create!(
        :profile => nil,
        :friend => nil,
        :mutual => false
      ),
      Friend.create!(
        :profile => nil,
        :friend => nil,
        :mutual => false
      )
    ])
  end

  it "renders a list of friends" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
