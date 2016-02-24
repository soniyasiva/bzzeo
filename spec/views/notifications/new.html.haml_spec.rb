require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      :message => "MyString",
      :link => "MyString",
      :profile => nil
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do

      assert_select "input#notification_message[name=?]", "notification[message]"

      assert_select "input#notification_link[name=?]", "notification[link]"

      assert_select "input#notification_profile_id[name=?]", "notification[profile_id]"
    end
  end
end
