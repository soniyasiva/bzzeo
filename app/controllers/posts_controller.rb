class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :comment]

  # handles comments for posts
  def comment
    @comment = Comment.create(comment_params)

    if request.xhr?
      render json: { comment: @comment, id: @post.id }
    else
      redirect_to @comment
    end
  end

  # handles likes and unlikes for posts
  def like
    @like = Like.find_by(profile: current_user.profile, post: @post)
    if @like.nil?
      @like = Like.create(profile: current_user.profile, post: @post)
    else
      @like.destroy
    end

    if request.xhr?
      render json: { count: @post.likes.size, id: @post.id }
    else
      redirect_to @post
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image_url, :video_url, :description, :post_category_id).merge(
        profile_id: current_user.profile.id
      )
    end

    # custom strong params for comment action
    def comment_params
      params.require(:comment).permit(:description).merge(
        profile_id: current_user.profile.id,
        post_id: @post.id
      )
    end
end
