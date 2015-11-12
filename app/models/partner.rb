class Partner < ActiveRecord::Base
  belongs_to :profile
  belongs_to :partner, class_name: "Profile"

  validates :profile, presence: true
  validates :partner, presence: true
end
