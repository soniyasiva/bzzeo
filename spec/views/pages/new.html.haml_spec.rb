require 'rails_helper'

RSpec.describe "pages/new", type: :view do
  before(:each) do
    assign(:page, Page.new(
      :html => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do

      assert_select "textarea#page_html[name=?]", "page[html]"

      assert_select "input#page_slug[name=?]", "page[slug]"
    end
  end
end
