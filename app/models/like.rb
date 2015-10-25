class Like < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post

  validates :profile, presence: true
  validates :post, presence: true
end
