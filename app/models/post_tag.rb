class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag

  validates :profile, presence: true
  validates :tag, presence: true
end
