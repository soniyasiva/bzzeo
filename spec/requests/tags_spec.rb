require 'rails_helper'

RSpec.describe "Tags", type: :feature do
  describe "GET /tags" do

    login

    it "works! (now write some real specs)" do
      visit tags_path
      expect(page).to have_content 'tags'
    end
  end
end
