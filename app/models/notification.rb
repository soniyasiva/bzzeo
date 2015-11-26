class Notification < ActiveRecord::Base
  belongs_to :profile

  validates :profile, presence: true
end
