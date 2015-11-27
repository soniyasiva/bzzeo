class PostsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :comment, :upvote, :downvote, :pin]

  # handles comments for posts
  def comment
    @comment = Comment.create(comment_params)

    if request.xhr?
      render json: { comment: @comment, id: @post.id, profile: @comment.profile }
    else
      redirect_to @comment
    end
  end

  # handles likes and unlikes for posts
  def like
    @post.like current_user
    if request.xhr?
      render json: { count: @post.likes.size, id: @post.id }
    end
  end

  # handles upvotes for posts
  def upvote
    @vote = @post.upvote current_user
    if @vote.nil?
      dislike = nil
    else
      dislike = @vote.dislike
    end
    if request.xhr?
      render json: { votes: @post.votes, id: @post.id, dislike: dislike }
    end
  end

  # handles downvotes for posts
  def downvote
    @vote = @post.downvote current_user
    if @vote.nil?
      dislike = nil
    else
      dislike = @vote.dislike
    end
    if request.xhr?
      render json: { votes: @post.votes, id: @post.id, dislike: dislike }
    end
  end

  # deals page
  def deals
    @category = PostCategory.find_by(name: 'promotion')
    @posts = Post.where(post_category: @category).sort {|a,b| a.votes <=> b.votes}
  end

  # handles pins for posts
  def pin
    puts "===== pin ====="
    @post.pin current_user
    if request.xhr?
      render json: { post: @post, id: @post.id }
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.paginate(:page => params[:page], :per_page => 10)
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
      params.require(:post).permit(:image_url, :video_url, :description, :mention_id, :post_category_id).merge(
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
