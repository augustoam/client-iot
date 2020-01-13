class Api::V2::BaseController < ActionController::API
  include JWTSessions::RailsAuthorization

  before_action :authorize_access_request!

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  def user_sessao
      @user_sessao = User.find_by(email: payload['email'])
  end

  def set_session_token
    session[:token] = params[:token] if params[:token]
  end

  private

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
