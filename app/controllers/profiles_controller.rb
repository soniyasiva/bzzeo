class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :friend]

  def friend
    puts "===== friend ====="
    puts params.inspect
    if @profile.friend? current_user
      # destroy all friendships with the profile
      @profile.frienders.where(friend_id: current_user.profile.id).destroy_all
      @profile.friendeds.where(profile_id: current_user.profile.id).destroy_all
    else
      # create a friendship
      @friend = Friend.create(friend: @profile, profile_id: current_user.profile.id)
    end
    puts @friend

    if request.xhr?
      render json: { friend: @friend, id: @profile.id }
    else
      redirect_to @friend
    end
  end

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:all_tags, :name, :video, :representitive, :phone, :status, :category_id, :user_id, :facebook, :twitter, :instagram)
    end

    # custom strong params for friend action
    def friend_params
      params.require(:friend).permit(:friend_id).merge(
        profile_id: current_user.profile.id
      )
    end
end
