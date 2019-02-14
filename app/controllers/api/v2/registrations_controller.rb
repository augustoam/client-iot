class Api::V2::RegistrationsController < Api::V2::BaseController
  def create
    unless Usuario.find_by(email: params[:email])
      @usuario = Usuario.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      if @usuario.password_match?
        if @usuario.valid?
          @usuario.save

          render json: { msg: 'Verifique seu email para prosseguir com a confirmação da sua conta!', usuario: @usuario.email }, status: :ok
        else
          render json: { msg: 'Este usuário não é válido!' }, status: :unauthorized
        end
      else
        render json: { msg: 'Senhas não são iguais!' }, status: :unauthorized
      end
    else
      render json: { msg: 'Este email já esta cadastrado!' }, status: :unauthorized
    end
    rescue StandardError => e
      render json: {error: e.message}, status: :error
  end
end
