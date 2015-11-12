require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  before(:each) do
    @profile = assign(:profile, create(:profile))
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do

      assert_select "input#profile_name[name=?]", "profile[name]"

      assert_select "input#profile_video[name=?]", "profile[video_url]"

      assert_select "input#profile_representitive[name=?]", "profile[representitive]"

      assert_select "input#profile_phone[name=?]", "profile[phone]"

      assert_select "input#profile_status[name=?]", "profile[status]"

      # assert_select "input#profile_category_id[name=?]", "profile[category_id]"

      # assert_select "input#profile_user_id[name=?]", "profile[user_id]"
    end
  end
end
