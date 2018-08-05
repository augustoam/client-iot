class Api::V1::BaseController < ActionController::API
  before_action :set_session_token

  def set_session_token
    session[:token] = params[:token] if params[:token]
  end
end
