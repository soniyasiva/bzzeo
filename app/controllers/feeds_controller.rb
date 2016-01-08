class FeedsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource
  # check_authorization
  # GET /feeds
  # GET /feeds.json
  def index
    # hacky pagination
    # posts
    @posts = Post.all.includes(:profile, {comments: :profile}, :likes)
    @posts = @posts.order(created_at: :desc)
    @posts = @posts.paginate(:page => params[:page], :per_page => 10)
    # shares
    @shares = Share.all.includes(:profile, post: [:profile, {comments: :profile}, :likes])
    @shares = @shares.order(created_at: :desc)
    @shares = @shares.paginate(:page => params[:page], :per_page => 10)
    # combine
    @items = (@posts.to_a + @shares.to_a).sort_by(&:created_at).reverse!
  end

  def search
    # sets vars or nil
    @category = params[:category_id] unless params[:category_id].blank?
    @query = params[:query] unless params[:query].blank?
    @address_query = params[:address]
    @address = geocode_address @address_query unless @address_query.blank?

    @profiles = Profile.search @query, @address, params[:page]
    @posts = Post.search @query, @category, params[:page]
    # search posts and profiles
    # combine the two result times and sort by created_at desc
    # @items = (@profiles.to_a + @posts.to_a)
    # profiles only
    @items = @profiles

    respond_to do |format|
      format.html { render 'split_index' }
      format.json { render json: @items }
    end
  end

  def tag
    @profiles = Profile.joins(:tags).where("tags.name = ?", params[:tag]) unless params[:tag].nil?
    @profiles = @profiles.paginate(:page => params[:page], :per_page => 10)
    @posts = Post.joins(:tags).where("tags.name = ?", params[:tag]) unless params[:tag].nil?
    @posts = @posts.paginate(:page => params[:page], :per_page => 10)
    @items = (@profiles.to_a + @posts.to_a).sort_by(&:created_at).reverse!
    render 'split_index'
  end

  private
  def geocode_address address
    return nil if address.blank?
    geo = Geokit::Geocoders::MultiGeocoder.geocode address
    if geo.success
      geo
    else
      flash[:notice] = "Address not valid"
      nil
    end
  end

end
