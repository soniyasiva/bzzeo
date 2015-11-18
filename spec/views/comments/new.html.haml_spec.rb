require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, build(:comment))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      # assert_select "input#comment_profile_id[name=?]", "comment[profile_id]"

      # assert_select "input#comment_post_id[name=?]", "comment[post_id]"

      assert_select "textarea#comment_description[name=?]", "comment[description]"
    end
  end
end
