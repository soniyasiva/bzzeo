class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  has_many :profile_tags
  # has_many :profiles, through: :profile_tags
  has_many :post_tags
  has_many :posts, through: :post_tags
end
