class Profile < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :profile_tags
  has_many :tags, through: :profile_tags
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :shares
  has_many :friender, :class_name => 'Friend', :foreign_key => 'profile_id'
  has_many :friended, :class_name => 'Friend', :foreign_key => 'friend_id'

  validates :user, presence: true
  validates_uniqueness_of :user_id

  # implement
  # checks to see whether the current profile is friended by the current user
  def friend? user
    true
  end

  def friends
    friender + friended
  end
end
