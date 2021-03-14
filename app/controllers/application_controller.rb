class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: :edit

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

  def move_to_index
    @prototype = Prototype.find(params[:id]) 
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
end
