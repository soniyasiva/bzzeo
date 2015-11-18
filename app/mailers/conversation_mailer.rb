class ConversationMailer < ApplicationMailer

  # sent when getting a new message
  def new_message_email conversation
    @conversation = conversation
    mail(
      to: @conversation.receiver.user.email,
      subject: "New message from #{@conversation.sender.name}"
    )
  end

end
