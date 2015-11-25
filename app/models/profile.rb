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
  has_many :mentions, :class_name => 'Post', :foreign_key => 'mention_id'
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
  has_many :views
  has_many :viewed, :class_name => 'View', :foreign_key => 'viewed_id'
  has_many :view_profiles, through: :views, :source => :profile
  has_many :viewed_profiles, through: :viewed, :source => :profile

  # validations
  validates :user, presence: true
  validates_uniqueness_of :user_id

  before_save :format_video
  before_save :validate_social_media_profiles
  before_save :extract_hash_tags

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
    self.video_url = extract_video_id video_url
    self.thumbnail_url = get_thumbnail video_url
  end

  # not implemented
  def validate_social_media_profiles
    # "https://www.facebook.com/#{facebook}"
    # "https://twitter.com/#{twitter}"
    # "https://www.instagram.com/#{instagram}/" # can't easily validate
  end

  # magic formula for score
  def score
    views.count + likes.count
  end

  # takes in strin
  # returns array of hashtags
  def extract_hash_tags
    self.tags.destroy_all
    description.scan(/\B#\w+/).each do |name|
      self.tags << Tag.where(name: name.strip).first_or_create!
    end
  end

  private
  # geocodes address to lat lng on create and update
  def geocode_address
    return if address.blank?
    geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
