class FeedsController < ApplicationController

  # GET /feeds
  # GET /feeds.json
  def index
    posts = Post.all
    shares = Share.all
    @items = (posts.to_a + shares.to_a).sort_by(&:created_at)
  end

end
