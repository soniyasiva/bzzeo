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
  def like user
    # get if like exists
    like = Like.find_by(profile: user.profile, post: self)
    if like.nil?
      like = Like.create(profile: user.profile, post: self)
    else
      like.destroy
    end
  end

  def liked? user
    likes.where(profile_id: user.profile.id).any?
  end

  # upvotes are dislike false
  def upvote user
    vote = Like.unscoped.find_by(profile: user.profile, post: self)
    if vote.nil?
      # upvote
      vote = Like.create(profile: user.profile, post: self, dislike: false)
    elsif vote.dislike == false
      # already upvoted
      vote.destroy
      vote = nil
    elsif vote.dislike.nil? || vote.dislike == true
      # catch likes and turn downvotes into upvotes
      vote.update(dislike: false)
    end
    return vote
  end

  def upvotes
    likes.unscoped.where(post: self).where(dislike: false)
  end

  def upvoted? user
    likes.unscoped.where(post: self).where(profile_id: user.profile.id).where(dislike: false).any?
  end

  # downvotes are dislike true
  def downvote user
    puts "===== downvote ====="
    vote = Like.unscoped.find_by(profile: user.profile, post: self)
    puts vote.inspect
    if vote.nil?
      # upvote
      vote = Like.create(profile: user.profile, post: self, dislike: true)
    elsif vote.dislike == true
      # already downvoted
      vote.destroy
      vote = nil
    elsif vote.dislike.nil? || vote.dislike == false
      # catch likes and turn upvotes into downvotes
      vote.update(dislike: true)
    end
    return vote
  end

  def downvotes
    likes.unscoped.where(post: self).where(dislike: true)
  end

  def downvoted? user
    likes.unscoped.where(post: self).where(profile_id: user.profile.id).where(dislike: true).any?
  end

  def votes
    upvotes.count - downvotes.count
  end

  # pins posts to the top of the profile page
  def pin user
    # auth
    return unless user == profile.user
    if pinned == false
      self.update(pinned: true)
    else
      self.update(pinned: false)
    end
  end

end
