class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :ensure_profile


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def ensure_profile
    if !current_user.nil? && current_user.profile.name.blank? && request.path != edit_profile_path(current_user.profile) && request.path != profile_path(current_user.profile)

      redirect_to edit_profile_path(current_user.profile)
      flash[:notice] = "Please fill our your profile."
    end
  end
end
