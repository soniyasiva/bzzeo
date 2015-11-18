require 'rails_helper'

RSpec.describe "views/show", type: :view do
  before(:each) do
    @view = assign(:view, View.create!(
      :profile => nil,
      :viewed => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
