class Notification < ActiveRecord::Base
  belongs_to :profile

  validates :profile, presence: true

  after_create :send_email

  # send mail
  def send_email
    ConversationMailer.new_notification_email(
      profile.user.email,
      link,
      message,
      message
    ).deliver
  end
end
