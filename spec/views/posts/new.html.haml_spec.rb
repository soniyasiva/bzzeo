require 'rails_helper'

RSpec.describe "posts/new", type: :view do


  before(:each) do
    assign(:post, build(:post))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_image_url[name=?]", "post[image_url]"

      assert_select "input#post_video_url[name=?]", "post[video_url]"

      assert_select "textarea#post_description[name=?]", "post[description]"

      # assert_select "input#post_profile_id[name=?]", "post[profile_id]"
    end
  end
end
