require 'rails_helper'

RSpec.describe "Profiles", type: :feature do

  describe "GET /profiles" do

    login

    it "works! (now write some real specs)" do
      visit profiles_path
      expect(page).to have_content 'profiles'
    end
  end

  describe "GET my own profile" do

    login

    it "visits my own profile page" do
      my_profile = create(:profile, :name => "MyProfile")
      visit profile_path(my_profile)
      expect(page).to have_content 'MyProfile'
    end

    it "edits a profile from form" do
      category = create(:category, :name => 'HVACa')
      expect(@user).not_to be_nil
      visit edit_profile_path(@user.profile)

      expect(page).to have_content 'Editing profile'

      fill_in 'Name', :with => 'Levy HVAC'
      fill_in 'Video', :with => 'https://www.youtube.com/watch?v=pt8VYOfr8To'
      fill_in 'Representitive', :with => 'Josh Levy'
      fill_in 'Phone', :with => '902 220 3560'
      fill_in 'Facebook', :with => 'levyhvac'
      fill_in 'Twitter', :with => '@levyhvac'
      fill_in 'Instagram', :with => ''
      select('HVACa', :from => 'Category')

      click_button 'Save'
      expect(page).to have_content 'success'
      save_and_open_page

      expect(page).to have_content 'Levy HVAC'
      expect(page).to have_content 'https://www.youtube.com/watch?v=pt8VYOfr8To'
      expect(page).to have_content 'Josh Levy'
      expect(page).to have_content '902 220 3560'
      expect(page).to have_content 'Driving a car'
      expect(page).to have_content 'levyhvac'
      expect(page).to have_content '@levyhvac'
      expect(page).to have_content 'HVACa'
    end

  end

end
