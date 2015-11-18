require 'rails_helper'

RSpec.describe "Posts", type: :feature do
  describe "GET /posts" do

    login

    it "works! (now write some real specs)" do
      visit posts_path
      expect(page).to have_content 'posts'
    end
  end
end
