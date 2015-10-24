class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :profiles
  has_many :users, through: :profiles
end
