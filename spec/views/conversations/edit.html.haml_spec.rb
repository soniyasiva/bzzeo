require 'rails_helper'

RSpec.describe "conversations/edit", type: :view do
  before(:each) do
    @conversation = assign(:conversation, Conversation.create!(
      :sender => nil,
      :receiver => nil,
      :message => "MyText",
      :read => false
    ))
  end

  it "renders the edit conversation form" do
    render

    assert_select "form[action=?][method=?]", conversation_path(@conversation), "post" do

      assert_select "input#conversation_sender_id[name=?]", "conversation[sender_id]"

      assert_select "input#conversation_receiver_id[name=?]", "conversation[receiver_id]"

      assert_select "textarea#conversation_message[name=?]", "conversation[message]"

      assert_select "input#conversation_read[name=?]", "conversation[read]"
    end
  end
end
