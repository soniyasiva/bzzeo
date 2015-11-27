class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  def index
    # hacky pagination
    @posts = Post.all.includes(:profile, {comments: :profile}, :likes).paginate(:page => params[:page], :per_page => 10)
    @shares = Share.all.includes(:profile, post: [:profile, {comments: :profile}, :likes]).paginate(:page => params[:page], :per_page => 10)
    @items = (@posts.to_a + @shares.to_a).sort_by(&:created_at)
    @view_type = params[:view_type]
  end

  def search
    puts "===== search ====="
    # sets vars or nil
    @category = params[:category_id] unless params[:category_id].blank?
    @query = params[:query] unless params[:query].blank?
    @address = geocode_address params[:address] unless params[:address].blank?

    # gets profiles
    @profiles = Profile.all
    # searches profiles for
    # profile name
    # profile tag names
    @profiles = @profiles.joins(:tags).where("profiles.name ILIKE ? OR tags.name ILIKE ?", "%#{@query}%", "%#{@query}%").uniq unless @query.nil?
    # filter by category
    @profiles = @profiles.where(category_id: @category) unless @category.nil?
    # sort by distance
    # within 100km, sorted by distance from origin, closest first
    @profiles = @profiles.within(100, :origin => @address).order(address: :asc) unless @address.nil?
    @profiles = @profiles.paginate(:page => params[:page], :per_page => 10)

    # searches posts also
    if @category.nil? && @address.nil?
      # gets posts
      @posts = Post.includes(:profile, {comments: :profile}, :likes)
      # searches posts for
      # description
      @posts = @posts.where("description ILIKE ?", "%#{@query}%") unless @query.nil?
      # preorder posts by created_at
      @posts = @posts.order(created_at: :desc)
      @posts = @posts.paginate(:page => params[:page], :per_page => 10)
      # combine the two result times and sort by created_at desc
      @items = (@posts.to_a + @profiles.to_a).sort_by do |item|
        item.created_at
      end.reverse!
    else
      @items = @profiles
    end

    # grid vs list view
    @view_type = params[:view_type]
    # debug
    puts "==== items ====="
    puts @items
    render 'index'
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
