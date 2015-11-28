class Notification < ActiveRecord::Base
  belongs_to :profile

  validates :profile, presence: true

  after_create :send_email

  # send mail
  def send_email
    NotificationMailer.new_notification_email(
      profile.user.email,
      "#{ENV['SITE']}#{link}",
      message,
      message
    ).deliver
  end
end
