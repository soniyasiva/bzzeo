class Page < ActiveRecord::Base
  # slugs
  extend FriendlyId
  friendly_id :slug, use: :slugged

  # validations
  validates :slug, presence: { strict: true }
  validates :html, presence: { strict: true }
end
