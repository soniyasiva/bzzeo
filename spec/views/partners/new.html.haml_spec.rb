require 'rails_helper'

RSpec.describe "partners/new", type: :view do
  before(:each) do
    assign(:partner, Partner.new(
      :profile => nil,
      :partner => nil
    ))
  end

  it "renders new partner form" do
    render

    assert_select "form[action=?][method=?]", partners_path, "post" do

      assert_select "input#partner_profile_id[name=?]", "partner[profile_id]"

      assert_select "input#partner_partner_id[name=?]", "partner[partner_id]"
    end
  end
end
