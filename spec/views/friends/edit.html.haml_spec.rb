require 'rails_helper'

RSpec.describe "friends/edit", type: :view do
  before(:each) do
    @friend = assign(:friend, Friend.create!(
      :profile => nil,
      :friend => nil,
      :mutual => false
    ))
  end

  it "renders the edit friend form" do
    render

    assert_select "form[action=?][method=?]", friend_path(@friend), "post" do

      assert_select "input#friend_profile_id[name=?]", "friend[profile_id]"

      assert_select "input#friend_friend_id[name=?]", "friend[friend_id]"

      assert_select "input#friend_mutual[name=?]", "friend[mutual]"
    end
  end
end
