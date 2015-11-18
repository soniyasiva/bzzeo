require 'rails_helper'

RSpec.describe "conversations/new", type: :view do
  before(:each) do
    assign(:conversation, Conversation.new(
      :sender => nil,
      :receiver => nil,
      :message => "MyText",
      :read => false
    ))
  end

  it "renders new conversation form" do
    render

    assert_select "form[action=?][method=?]", conversations_path, "post" do

      assert_select "input#conversation_sender_id[name=?]", "conversation[sender_id]"

      assert_select "input#conversation_receiver_id[name=?]", "conversation[receiver_id]"

      assert_select "textarea#conversation_message[name=?]", "conversation[message]"

      assert_select "input#conversation_read[name=?]", "conversation[read]"
    end
  end
end
