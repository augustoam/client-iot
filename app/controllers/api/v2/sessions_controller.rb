class Api::V2::SessionsController < Api::V2::BaseController
  skip_before_action :authorize_access_request!

  def reset_password
    resource = User.find_by_email(params['email'])
    if resource.present?
      resource.send_reset_password_instructions
      render json: { user: resource.email }, status: :ok
    else
      render json: { msg: 'Email inválido!' }, status: :unauthorized
    end
  end

  def create
    service = SessionAuthenticationService.new(user_session_params).call

    render(service.success? ? service.server_payload : service.server_error)

    rescue StandardError => e
      render json: {error: e.message}, status: :unauthorized
  end

  private

  def user_session_params
    {
      email: params[:email],
      password: params[:password]
    }
  end
end
