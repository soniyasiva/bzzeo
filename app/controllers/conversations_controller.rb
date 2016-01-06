class ConversationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  check_authorization
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @inbox = Conversation.where(receiver: current_user.profile)
    @sent = Conversation.where(sender: current_user.profile)
  end

  def dashboard
    # profiles with conversations
    @profiles = (current_user.profile.receivers.pluck(:sender_id) + current_user.profile.senders.pluck(:receiver_id)).uniq.map {|p| Profile.find(p)}
    if @profile_id.nil?
      @profile_id = @profiles.first.id unless @profiles.blank?
    else
      @profile_id = params[:profile_id].to_i
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation.update(read: true) if @conversation.receiver_id == current_user.id
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
    @conversation.receiver_id = params[:profile_id] unless params[:profile_id].nil?
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to dashboard_conversations_path(profile_id: @conversation.receiver_id), notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:receiver_id, :message, :read).merge(
        sender_id: current_user.profile.id
      )
    end
end
