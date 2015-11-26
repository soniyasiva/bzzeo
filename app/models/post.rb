include Video

class Post < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post_category
  belongs_to :mention, class_name: "Profile"
  has_many :comments
  has_many :likes
  has_many :shares

  validates :profile, presence: true
  validate :has_content
  validate :does_not_have_video_and_image
  validate :has_mention_for_review

  before_save :format_video

  after_create :notify

  # notifications
  def notify
    return if mention.nil?
    Notification.create(
      profile: mention,
      message: "#{profile.name} mentioned you in a post.",
      link: "/posts/#{id}"
    )
  end

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

  def has_mention_for_review
    errors[:base] << "Review must mention a profile" if post_category_id == PostCategory.find_by(name: 'review').id && mention_id.blank?
  end

  # likes are dislike nil
  def liked? user
    likes.where(profile_id: user.profile.id).any?
  end

  # upvotes are dislike false
  def upvotes
    likes.unscoped.where(dislike: false)
  end

  def upvoted? user
    likes.unscoped.where(profile_id: user.profile.id).where(dislike: false).any?
  end

  # downvotes are dislike true
  def downvotes
    likes.unscoped.where(dislike: true)
  end

  def downvoted? user
    likes.unscoped.where(profile_id: user.profile.id).where(dislike: true).any?
  end
end
