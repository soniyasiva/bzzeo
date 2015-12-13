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
  has_many :notifications

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
  # returns array of tags
  def extract_hash_tags
    self.profile_tags.destroy_all
    return if description.blank?
    description.scan(/\B#\w+/).each do |name|
      self.tags << Tag.where(name: name.delete!('#')).first_or_create!
    end
  end

  # takes in strin
  # returns array of tags
  def tagged_description
    return nil if description.nil?
    t_desc = description
    description.scan(/\B#\w+/).each do |name|
      tag = Tag.find_by(name: name.delete!('#'))
      t_desc.sub! "##{name}", "<a href=\"/feeds/tag/#{tag.name}\">##{tag.name}</a>"
    end
    t_desc
  end

  # searches the profiles name and tags by keyword and optional address
  def self.search query, address=nil, page
    # catch blank search
    return [] if query.nil? and address.nil?
    # gets profiles
    profiles = Profile.all
    # searches profiles for
    # profile name, socials
    # profile tag names
    # profile user email
    profiles = profiles.joins(:tags, :user).where("
      users.email ILIKE ? OR
      profiles.phone ILIKE ? OR
      profiles.facebook ILIKE ? OR
      profiles.instagram ILIKE ? OR
      profiles.twitter ILIKE ? OR
      profiles.name ILIKE ? OR
      tags.name ILIKE ?
    ",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%").uniq
    # sort by distance
    # within 100km, sorted by distance from origin, closest first
    profiles = profiles.within(100, :origin => address).order(address: :asc) unless address.nil?
    profiles = profiles.paginate(:page => page, :per_page => 10)
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
