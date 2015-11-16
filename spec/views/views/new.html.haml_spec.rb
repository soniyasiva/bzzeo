require 'rails_helper'

RSpec.describe "views/new", type: :view do
  before(:each) do
    assign(:view, View.new(
      :profile => nil,
      :viewed => nil
    ))
  end

  it "renders new view form" do
    render

    assert_select "form[action=?][method=?]", views_path, "post" do

      assert_select "input#view_profile_id[name=?]", "view[profile_id]"

      assert_select "input#view_viewed_id[name=?]", "view[viewed_id]"
    end
  end
end
