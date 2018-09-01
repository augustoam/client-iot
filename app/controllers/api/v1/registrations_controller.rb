class Api::V1::RegistrationsController < Api::V1::BaseController
  def registration_new
    usuario = Usuario.new(
      email: JSON.parse(params[:email]),
      password: JSON.parse(params[:password]),
      password_confirmation: JSON.parse(params[:password])
    )
    if usuario.valid?
      usuario.save
      usuario.confirm
      token_notificacao = JSON.parse(params[:token_notificacao])
      unless usuario.tokens_notificacao_mobile.find_by(token: token_notificacao)
        if token_notificacao != 'undefined'
          usuario.tokens_notificacao_mobile.create!(token: token_notificacao)
        end
      end
      debugger
      render json: { usuario: usuario.email, token: usuario.token }, status: :ok
    else
      render json: { msg: 'Este email já esta cadastrado!' }, status: :unauthorized
    end
  end
end
