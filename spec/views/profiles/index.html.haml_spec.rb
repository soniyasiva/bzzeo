require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      create(:profile),
      create(:profile)
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "First Exit Media".to_s, :count => 2
    assert_select "tr>td", :text => "https://www.youtube.com/watch?v=-9dAhOsyXBk".to_s, :count => 2
    assert_select "tr>td", :text => "Zach Levy".to_s, :count => 2
    assert_select "tr>td", :text => "647 667 5215".to_s, :count => 2
    assert_select "tr>td", :text => "Coding until dawn".to_s, :count => 2
    # assert_select "tr>td", :text => profile1.category.to_s, :count => 2
    # assert_select "tr>td", :text => profile1.user.to_s, :count => 2
  end
end
