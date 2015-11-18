require 'rails_helper'

RSpec.describe "likes/new", type: :view do
  before(:each) do
    assign(:like, build(:like))
  end

  it "renders new like form" do
    render

    assert_select "form[action=?][method=?]", likes_path, "post" do

      # assert_select "input#like_profile_id[name=?]", "like[profile_id]"

      # assert_select "input#like_post_id[name=?]", "like[post_id]"
    end
  end
end
