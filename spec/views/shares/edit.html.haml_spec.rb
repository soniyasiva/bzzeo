require 'rails_helper'

RSpec.describe "shares/edit", type: :view do
  before(:each) do
    @share = assign(:share, create(:share))
  end

  it "renders the edit share form" do
    render

    assert_select "form[action=?][method=?]", share_path(@share), "post" do

      # assert_select "input#share_post_id[name=?]", "share[post_id]"

      # assert_select "input#share_profile_id[name=?]", "share[profile_id]"
    end
  end
end
