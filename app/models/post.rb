include Video

class Post < ActiveRecord::Base
  belongs_to :profile
  belongs_to :post_category
  belongs_to :mention, class_name: "Profile"
  has_many :comments
  has_many :likes
  has_many :shares
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :profile, presence: true
  validate :has_content
  validate :does_not_have_video_and_image
  validate :has_mention_for_review

  before_save :format_video
  before_save :extract_hash_tags

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

  def meta_image
    if !thumbnail_url.blank?
      thumbnail_url
    elsif !image_url.blank?
      image_url
    else
      nil
    end
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

  def promotion?
    !post_category.nil? && post_category == PostCategory.find_by(name: 'promotion')
  end

  # searches the posts by keyword and optional category
  def self.search query, category_id=nil, page
    return [] if query.nil? and category_id.nil?
    # gets posts
    posts = Post.includes(:profile, {comments: :profile}, :likes)
    # filter by category
    posts = posts.where(post_category_id: category_id) unless category_id.nil?
    # searches posts for
    # description
    posts = posts.where("description ILIKE ?", "%#{query}%") unless query.nil?
    # preorder posts by created_at
    posts = posts.order(created_at: :desc)
    posts = posts.paginate(:page => page, :per_page => 10)
    return posts
  end

  # tag form helper on display
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  # takes in strin
  # returns array of tags
  def extract_hash_tags
    self.post_tags.destroy_all
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

end
