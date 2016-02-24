require 'rails_helper'

RSpec.describe "partners/edit", type: :view do
  before(:each) do
    @partner = assign(:partner, Partner.create!(
      :profile => nil,
      :partner => nil
    ))
  end

  it "renders the edit partner form" do
    render

    assert_select "form[action=?][method=?]", partner_path(@partner), "post" do

      assert_select "input#partner_profile_id[name=?]", "partner[profile_id]"

      assert_select "input#partner_partner_id[name=?]", "partner[partner_id]"
    end
  end
end
