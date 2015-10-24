class Profile < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :tags

  validates :user, presence: true
end
