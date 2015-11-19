class FeedsController < ApplicationController

  # GET /feeds
  # GET /feeds.json
  def index
    posts = Post.all.includes(:profile, {comments: :profile}, :likes)
    shares = Share.all.includes(:profile, post: [:profile, {comments: :profile}, :likes])
    @items = (posts.to_a + shares.to_a).sort_by(&:created_at)
  end

  def search
    puts "===== search ====="
    query = params[:query]
    # searches profiles for
    # profile name
    # profile tag names
    profiles = Profile.joins(:tags).where("profiles.name ILIKE ? OR tags.name ILIKE ?", "%#{query}%", "%#{query}%").uniq
    # searches posts for
    # description
    posts = Post.includes(:profile, {comments: :profile}, :likes).where("description ILIKE ?", "%#{query}%")
    @items = (posts.to_a + profiles.to_a).sort_by(&:created_at)
    # debug
    puts "==== items ====="
    puts @items
    render 'search_results'
  end

end
