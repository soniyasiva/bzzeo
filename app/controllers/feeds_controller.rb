class FeedsController < ApplicationController

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Post.all
  end

end
