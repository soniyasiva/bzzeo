class View < ActiveRecord::Base
  belongs_to :profile
  belongs_to :viewed, class_name: "Profile"

  validates :profile, presence: true
  validates :viewed, presence: true
end
