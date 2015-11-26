class Friend < ActiveRecord::Base
  belongs_to :profile
  belongs_to :friend, class_name: "Profile"

  validates :profile, presence: true
  validates :friend, presence: true

  after_create :notify

  # notifications
  def notify
    Notification.create(
      profile: friend,
      message: "#{profile.name} followed you.",
      link: "/profiles/#{profile.id}"
    )
  end
end
