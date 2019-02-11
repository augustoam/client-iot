class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authorize_access_request!

  def session_new
    usuario = Usuario.find_by_email(params[:email])
    if usuario.present?
      token_notificacao = params[:token_notificacao]
      # Cria o token para notificação para o dispositivo do cliente
      unless usuario.tokens_notificacao_mobile.find_by(token: token_notificacao)
        if token_notificacao != 'undefined'
          usuario.tokens_notificacao_mobile.create!(token: token_notificacao)
        end
      end
      render json: { usuario: usuario.email, token: usuario.token }, status: :ok
    else
      render json: { msg: 'Email inválido!' }, status: :unauthorized
    end
  end

  def reset_password
    resource = Usuario.find_by_email(params['email'])
    if resource.present?
      resource.send_reset_password_instructions
      render json: { usuario: resource.email }, status: :ok
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
