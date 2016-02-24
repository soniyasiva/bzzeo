require 'rails_helper'

RSpec.describe "views/edit", type: :view do
  before(:each) do
    @view = assign(:view, View.create!(
      :profile => nil,
      :viewed => nil
    ))
  end

  it "renders the edit view form" do
    render

    assert_select "form[action=?][method=?]", view_path(@view), "post" do

      assert_select "input#view_profile_id[name=?]", "view[profile_id]"

      assert_select "input#view_viewed_id[name=?]", "view[viewed_id]"
    end
  end
end
