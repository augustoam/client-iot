class Api::V1::SessionsController < Api::V1::BaseController
  def session_new
    usuario = Usuario.find_by_email(params['email'])
    if usuario.present?
      if usuario.valid_password?(params['password'])
        if usuario.confirmed?
          # Cria o token para notificação para o dispositivo do cliente
          unless usuario.tokens_notificacao_mobile.find_by(token: params[:token_notificacao])
            if params[:token_notificacao] != 'undefined'
              usuario.tokens_notificacao_mobile.create!(token: params[:token_notificacao])
            end
          end
          sign_in :Usuario, usuario
          render json: { usuario: usuario.email, token: usuario.token }, status: :ok
        else
          render json: { msg: 'Email não confirmado!' }, status: :unauthorized
        end
      else
        render json: { msg: 'Senha inválida!' }, status: :unauthorized
      end
    else
      render json: { msg: 'Email inválido!' }, status: :unauthorized
    end
  end
end
