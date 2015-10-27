require 'rails_helper'

RSpec.describe "Profiles", type: :feature do

  describe "GET /profiles" do

    login

    it "works! (now write some real specs)" do
      visit profiles_path
      expect(page).to have_content 'profiles'
    end
  end

end
