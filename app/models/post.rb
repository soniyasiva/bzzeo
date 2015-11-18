include Video

class Post < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post_category
  has_many :comments
  has_many :likes
  has_many :shares

  validates :profile, presence: true
  validate :has_content
  validate :does_not_have_video_and_image

  before_save :format_video

  def format_video
    self.video_url = extract_video_id video_url
    self.thumbnail_url = get_thumbnail video_url
  end

  def has_content
    errors[:base] << "Post needs some form of content" if image_url.blank? && video_url.blank? && description.blank?
  end

  def does_not_have_video_and_image
    errors[:base] << "Post cannot have both an image and video" if !image_url.blank? && !video_url.blank?
  end

  def liked? user
    likes.where(profile_id: user.profile.id).any?
  end
end
