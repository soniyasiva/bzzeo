class NotificationMailer < ApplicationMailer

  # sent when getting a new message
  def new_notification_email to, link, subject, message
    @subject = subject
    @message = message
    @to = to
    @link = link
    mail(
      to: @to,
      subject: @subject
    )
  end

end
