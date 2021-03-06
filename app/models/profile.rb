include Video
require 'will_paginate/array'

class Profile < ActiveRecord::Base
  # slugs
  extend FriendlyId
  friendly_id :name, use: :slugged

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
  validates :name, presence: true

  before_save :format_video
  before_save :validate_social_media_profiles
  before_save :extract_hash_tags

  # friendly id name change update slug
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

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

  def last_conversation with_profile
    last_sent = senders.where(receiver: with_profile).last
    last_received = receivers.where(sender: with_profile).last
    last = last_sent
    last = last_received if last_sent.nil? || (!last_received.nil? && last_received.created_at > last_sent.created_at)
  end

  def conversations with_profile=nil
    if with_profile.nil?
      (senders + receivers).sort_by(&:created_at)
    else
      (senders.where(receiver: with_profile) + receivers.where(sender: with_profile)).sort_by(&:created_at)
    end
  end

  # returns array of profiles that the user has had conversations with. In order of most recent conversation
  def conversationalists
    # profiles with conversations
    # convos newest first
    profiles = (receivers + senders).sort_by(&:created_at).reverse
    # conversation with ids
    profiles = profiles.map do |c|
      if c.receiver_id == id
        c.sender_id
      else
        c.receiver_id
      end
    end.uniq # profiles, newest first
    # get profiles
    profiles = profiles.map {|p| Profile.find(p)}
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
    views.count + likes.count + posts.count
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
    return [] if query.nil? && address.nil?
    # gets profiles
    profiles = Profile.all
    # searches profiles for
    # profile name, socials
    # profile tag names
    # profile user email

    # filter by distance
    profiles = profiles.within(100, :origin => address).order(address: :asc) unless address.nil?

    # separate because active record OR clauses suck
    tag_profiles = profiles.joins(:tags).where("tags.name ILIKE ?", "%#{query}%")
    name_profiles = profiles.where("name ILIKE ?", "%#{query}%")
    category_profiles = profiles.joins(:category).where("categories.name ILIKE ?", "%#{query}%")

    profiles = (name_profiles.to_a + category_profiles.to_a + tag_profiles.to_a).uniq

    # sort by distance. this might not actually work
    profiles = profiles.sort_by(&:address)

    # within 100km, sorted by distance from origin, closest first
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
