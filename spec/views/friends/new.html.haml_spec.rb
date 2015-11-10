require 'rails_helper'

RSpec.describe "friends/new", type: :view do
  before(:each) do
    assign(:friend, Friend.new(
      :profile => nil,
      :friend => nil,
      :mutual => false
    ))
  end

  it "renders new friend form" do
    render

    assert_select "form[action=?][method=?]", friends_path, "post" do

      assert_select "input#friend_profile_id[name=?]", "friend[profile_id]"

      assert_select "input#friend_friend_id[name=?]", "friend[friend_id]"

      assert_select "input#friend_mutual[name=?]", "friend[mutual]"
    end
  end
end
