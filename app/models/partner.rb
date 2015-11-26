class Partner < ActiveRecord::Base
  belongs_to :profile
  belongs_to :partner, class_name: "Profile"

  validates :profile, presence: true
  validates :partner, presence: true

  after_create :notify

  # notifications
  def notify
    Notification.create(
      profile: partner,
      message: "#{profile.name} added you as a partner.",
      link: "/profiles/#{profile.id}"
    )
  end
end
