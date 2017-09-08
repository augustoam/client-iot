class ContasController < ApplicationController
  include ControllerResponder
  before_action :set_usuario, only: [:destroy]

  def new
    @usuario = Usuario.new
  end

  def create
    generated_password = Devise.friendly_token.first(8)
    @usuario = Usuario.create(email: params[:usuario][:email], password: generated_password)
    if @usuario.valid?
      @usuario.save
      save_and_respond @usuario, notice: "Um e-mail para confirmação da conta será enviado em alguns instantes para #{@usuario.email}", redirect: usuarios_url
    end
  end

  def destroy
    @usuario.destroy
    redirect_to root_url, notice: 'Usuario excluído com sucesso.'
  end

  private
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:email, :password, :password_confirmation, :grupo_usuario_id)
    end
end