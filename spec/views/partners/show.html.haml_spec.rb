require 'rails_helper'

RSpec.describe "partners/show", type: :view do
  before(:each) do
    @partner = assign(:partner, Partner.create!(
      :profile => nil,
      :partner => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
