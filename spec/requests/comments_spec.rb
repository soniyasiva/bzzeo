require 'rails_helper'

RSpec.describe "Comments", type: :feature do
  describe "GET /comments" do

    login

    it "works! (now write some real specs)" do
      visit comments_path
      expect(page).to have_content 'comments'
    end
  end
end
