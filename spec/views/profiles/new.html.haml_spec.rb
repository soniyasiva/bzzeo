require 'rails_helper'

RSpec.describe "profiles/new", type: :view do
  before(:each) do
    assign(:profile, Profile.new(
      :name => "MyString",
      :video => "MyString",
      :representitive => "MyString",
      :phone => "MyString",
      :status => "MyString",
      :category => nil,
      :user => nil
    ))
  end

  it "renders new profile form" do
    render

    assert_select "form[action=?][method=?]", profiles_path, "post" do

      assert_select "input#profile_name[name=?]", "profile[name]"

      assert_select "input#profile_video[name=?]", "profile[video]"

      assert_select "input#profile_representitive[name=?]", "profile[representitive]"

      assert_select "input#profile_phone[name=?]", "profile[phone]"

      assert_select "input#profile_status[name=?]", "profile[status]"

      # assert_select "input#profile_category_id[name=?]", "profile[category_id]"

      # assert_select "input#profile_user_id[name=?]", "profile[user_id]"
    end
  end
end
