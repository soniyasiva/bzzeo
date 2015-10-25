require 'rails_helper'

RSpec.describe "shares/new", type: :view do
  before(:each) do
    assign(:share, build(:share))
  end

  it "renders new share form" do
    render

    assert_select "form[action=?][method=?]", shares_path, "post" do

      # assert_select "input#share_post_id[name=?]", "share[post_id]"

      # assert_select "input#share_profile_id[name=?]", "share[profile_id]"
    end
  end
end
