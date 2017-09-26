class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_action :authenticate_any!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_usuario!
    end
  end

  def current_user
    current_usuario
  end

  private
    def pundit_user
      current_usuario
    end

    def user_not_authorized
      flash[:alert] = 'Você não tem autorização'
      redirect_to(request.referrer || root_path)
    end

end
