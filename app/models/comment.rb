class Comment < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post

  validates :post, presence: true
  validates :profile, presence: true
  validates :description, presence: true
  validate :description_not_blank

  def description_not_blank
    errors[:base] << "Comment description cannot be blank" if description.blank?
  end
end
