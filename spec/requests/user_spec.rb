require 'rails_helper'

RSpec.describe "Users", type: :feature do

  describe "user login" do

    before :each do
      create(:user, :email => "zacharyalevy@gmail.com")
    end

    it "logs the user in in" do
      visit '/users/sign_in'
      expect(page).to have_content('Log in')
      within '#new_user' do
        fill_in 'Email', :with => 'zacharyalevy@gmail.com'
        fill_in 'Password', :with => 'password'
        click_button 'Log in'
      end
      expect(page).to have_content 'success'
    end

  end
end
