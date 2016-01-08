class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: "Profile"
  belongs_to :receiver, class_name: "Profile"

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :message, presence: { strict: true}

  after_create :notify

  # notifications
  def notify
    Notification.create(
      profile: receiver,
      message: "You have a new message from #{sender.name}.",
      link: "/conversations/dashboard?profile_id=#{receiver_id}"
    )
  end
end
