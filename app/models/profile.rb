class Profile < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :user, presence: true
end
