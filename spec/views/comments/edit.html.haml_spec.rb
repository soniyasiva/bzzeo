require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, create(:comment))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      # assert_select "input#comment_profile_id[name=?]", "comment[profile_id]"

      # assert_select "input#comment_post_id[name=?]", "comment[post_id]"

      assert_select "textarea#comment_description[name=?]", "comment[description]"
    end
  end
end
