require 'rails_helper'

RSpec.describe "likes/edit", type: :view do
  before(:each) do
    @like = assign(:like, create(:like))
  end

  it "renders the edit like form" do
    render

    assert_select "form[action=?][method=?]", like_path(@like), "post" do

      # assert_select "input#like_profile_id[name=?]", "like[profile_id]"

      # assert_select "input#like_post_id[name=?]", "like[post_id]"
    end
  end
end
