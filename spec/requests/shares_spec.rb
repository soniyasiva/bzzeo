require 'rails_helper'

RSpec.describe "Shares", type: :feature do
  describe "GET /shares" do

    login

    it "works! (now write some real specs)" do
      visit shares_path
      expect(page).to have_content 'shares'
    end
  end
end
