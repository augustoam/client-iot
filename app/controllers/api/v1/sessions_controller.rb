class Api::V1::SessionsController < Api::V1::BaseController
  def session_new
    user = User.find_by_email(params[:email])
    if user.present?
      notification_token = params[:notification_token]
      # Cria o token para notificação para o dispositivo do cliente
      unless user.notification_tokens.find_by(token: notification_token)
        if notification_token != 'undefined'
          user.notification_tokens.create!(token: notification_token)
        end
      end
      render json: { user: user.email, token: user.token }, status: :ok
    else
      render json: { msg: 'Email inválido!' }, status: :unauthorized
    end
  end

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