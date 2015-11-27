class Page < ActiveRecord::Base
  # slugs
  extend FriendlyId
  friendly_id :title, use: :slugged

  # validations
  validates :title, presence: { strict: true }
  validates :html, presence: { strict: true }
end
