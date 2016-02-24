require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, create(:post))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_image_url[name=?]", "post[image_url]"

      assert_select "input#post_video_url[name=?]", "post[video_url]"

      assert_select "textarea#post_description[name=?]", "post[description]"

      # assert_select "input#post_profile_id[name=?]", "post[profile_id]"
    end
  end
end
