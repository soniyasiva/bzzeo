class Profile < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :profile_tags
  has_many :tags, through: :profile_tags
  has_many :posts
  has_ment :comments

  validates :user, presence: true
end
