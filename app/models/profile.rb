include Video

class Profile < ActiveRecord::Base
  # geo
  acts_as_mappable
  before_validation :geocode_address, :on => [:create, :update]

  # associations
  belongs_to :category
  belongs_to :user
  has_many :profile_tags
  has_many :tags, through: :profile_tags
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :shares
  has_many :frienders, :class_name => 'Friend', :foreign_key => 'profile_id'
  has_many :friendeds, :class_name => 'Friend', :foreign_key => 'friend_id'
  has_many :senders, :class_name => 'Conversation', :foreign_key => 'sender_id'
  has_many :receivers, :class_name => 'Conversation', :foreign_key => 'receiver_id'
  has_many :partners, :class_name => 'Partner', :foreign_key => 'profile_id'
  has_many :partnered, :class_name => 'Partner', :foreign_key => 'partner_id'
  has_many :partner_profiles, through: :partners, :source => :partner

  # validations
  validates :user, presence: true
  validates_uniqueness_of :user_id

  before_save :format_video

  # checks to see whether the current profile is friended by the user. should be passed current_user
  def friend? user
    frienders.where(friend_id: user.profile.id).any? || friendeds.where(profile_id: user.profile.id).any?
  end

  # checks to see whether the current profile is partners by the user. should be passed current_user
  def partner? user
    partnered.where(profile_id: user.profile.id).any?
  end

  def friends
    frienders + friendeds
  end

  def conversations
    senders + receivers
  end

  # tag form helper on submit
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  # tag form helper on display
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def format_video
    self.video = extract_video_id video
  end

  private
  # geocodes address to lat lng on create and update
  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
