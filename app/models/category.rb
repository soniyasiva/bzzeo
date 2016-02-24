class Category < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  has_many :profiles
  has_many :users, through: :profiles
end
