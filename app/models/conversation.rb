class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: "Profile"
  belongs_to :receiver, class_name: "Profile"

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :message, presence: { strict: true}
end
