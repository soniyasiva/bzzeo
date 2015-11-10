class Friend < ActiveRecord::Base
  belongs_to :profile
  belongs_to :friend, class_name: "Profile"

  validates :profile, presence: true
  validates :friend, presence: true
end
