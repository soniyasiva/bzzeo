class ProfileTag < ActiveRecord::Base
  belongs_to :profile
  belongs_to :tag

  validates :profile, presence: true
  validates :tag, presence: true
end
