class Like < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post

  validates :profile, presence: true
  validates :post, presence: true

  # defaults where dislikes are nil
  # upvotes are dislike false
  # downvotes are dislike true
  def self.default_scope
    where(dislike: nil)
  end
end
