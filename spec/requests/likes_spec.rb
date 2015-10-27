require 'rails_helper'

RSpec.describe "Likes", type: :feature do
  describe "GET /likes" do

    login

    it "works! (now write some real specs)" do
      visit likes_path
      expect(page).to have_content 'likes'
    end
  end
end
