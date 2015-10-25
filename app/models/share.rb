class Share < ActiveRecord::Base
  belongs_to :post
  belongs_to :profile

  validates :post, presence: true
  validates :profile, presence: true
end
