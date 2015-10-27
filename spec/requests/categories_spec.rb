require 'rails_helper'

RSpec.describe "Categories", type: :feature do
  describe "GET /categories" do

    login

    it "works! (now write some real specs)" do
      visit categories_path
      expect(page).to have_content 'categories'
    end
  end
end
