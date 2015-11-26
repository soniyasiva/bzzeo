require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :message => "MyString",
      :link => "MyString",
      :profile => nil
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input#notification_message[name=?]", "notification[message]"

      assert_select "input#notification_link[name=?]", "notification[link]"

      assert_select "input#notification_profile_id[name=?]", "notification[profile_id]"
    end
  end
end
