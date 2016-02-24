require 'rails_helper'

RSpec.describe "partners/index", type: :view do
  before(:each) do
    assign(:partners, [
      Partner.create!(
        :profile => nil,
        :partner => nil
      ),
      Partner.create!(
        :profile => nil,
        :partner => nil
      )
    ])
  end

  it "renders a list of partners" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
