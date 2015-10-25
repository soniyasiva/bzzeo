class Post < ActiveRecord::Base
  belongs_to :profile

  validates :profile, presence: true
  validate :has_content
  validate :does_not_have_video_and_image

  def has_content
    errors[:base] << "Post needs some form of content" if image_url.blank? && video_url.blank? && description.blank?
  end

  def does_not_have_video_and_image
    errors[:base] << "Post cannot have both an image and video" if !image_url.blank? && !video_url.blank?
  end
end
