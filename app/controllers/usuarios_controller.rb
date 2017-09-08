class UsuariosController < ApplicationController
  before_action :set_grupo, only: [:create]
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def index
    @usuarios = Usuario.all
  end

  def show
  end

  def new
    @usuario = Usuario.new
  end

  def edit
  end

  def create
    debugger
    if params[:usuario]
      @grupo_usuario = @grupo.grupos_usuarios.new(grupo_id: @grupo)

      @usuario = Usuario.find_by(email: params[:usuario][:email])
      if @usuario
        if @grupo.usuarios.include?(@usuario)
          redirect_to grupo_grupos_usuarios_path(@grupo), alert: "Usuário #{@administrador_grupo.email} já é administrador deste grupo"
        end
      else
        password = Devise.friendly_token.first(8)
        @usuario = Usuario.create!(email: params[:usuario][:email], password: password)
        @grupo_usuario.usuario = @usuario
        @grupo_usuario.save

        ConvidarUsuarioByEmailJob.perform_later(@usuario)

        redirect_to grupo_grupos_usuarios_path(@grupo), notice: "Usuário criado com sucesso"
      end
    else
      authorize @grupo, :show?
      redirect_to grupo_path(@grupo), alert: "Informe um e-mail válido"
    end
  end

  def update
    @usuario.assign_attributes(usuario_params.except(:password, :password_confirmation))
    if(!usuario_params[:password].to_s.empty?) && usuario_params[:password].to_s != @usuario.password
      @usuario.password = usuario_params[:password]
      @usuario.password_confirmation = usuario_params[:password_confirmation]
    end

    save_and_respond @usuario, notice: "Usuário alterado com sucesso"
  end

  def destroy
    destroy_and_respond @usuario, usuarios_url, "Usuário removido com sucesso"
  end


  private
    def set_grupo
      @grupo = Grupo.find(params[:usuario][:grupo_id])
    end

    def set_usuario
      @usuario = Usuario.with_deleted.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:email, :admin)
    end

end
