class Api::V1::SessionsController < Api::V1::BaseController
  def session_new
    usuario = Usuario.find_by_email(JSON.parse(params['email']))
    if usuario.present?
      token_notificacao = JSON.parse(params[:token_notificacao])
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
end
