class Admin::UsuariosController < ApplicationController
  layout 'admin'
  before_action :set_grupo, only: [:index, :new, :create, :edit, :show, :update, :destroy, :remover]
  before_action :set_usuario, only: [:show, :edit, :update, :destroy, :remover]
  
  def index
    @q = @grupo.usuarios.ransack(params[:q])
    @usuarios = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @usuario = Usuario.new
  end

  def edit
  end

  def show
  end

  def create
    if params[:usuario]
      @grupo_usuario = @grupo.grupos_usuarios.new
      @usuario = Usuario.find_by(email: params[:usuario][:email])
      if @usuario
        if @grupo.usuarios.include?(@usuario)
          redirect_to admin_grupo_usuarios_path(@grupo), alert: "Usuário #{@usuario.email} já pertence a esse grupo"
        else
          @grupo_usuario.usuario = @usuario
          @grupo_usuario.save
          redirect_to admin_grupo_usuarios_path(@grupo), alert: "Usuário #{@usuario.email} vinculado a este grupo"
        end
      else
        password = Devise.friendly_token.first(8)
        @usuario = Usuario.create!(email: params[:usuario][:email], password: password)
        @grupo_usuario.usuario = @usuario
        @grupo_usuario.save

        ConvidarUsuarioByEmailJob.perform_later(@usuario)

        redirect_to admin_grupo_usuarios_path(@grupo), notice: "Usuário criado com sucesso"
      end
    else
      render :new, alert: "Informe um e-mail válido"
    end
  end

  def update
    if @usuario.update(usuario_params)
      redirect_to admin_grupo_usuario_path(@grupo, @usuario), notice: "#{Usuario.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def remover
    grupo_usuario = GrupoUsuario.find_by(grupo_id: @grupo, usuario_id: @usuario)
    grupo_usuario.destroy
    redirect_to admin_grupo_usuarios_path(@grupo), notice: "#{Usuario.model_name.human} removido do grupo com sucesso."
  end

  def destroy
    @usuario.destroy
    redirect_to admin_grupo_usuarios_path(@grupo), notice: "#{Usuario.model_name.human} excluído com sucesso."
  end
  
  private
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    def set_grupo
      @grupo = Grupo.find(params[:grupo_id])
    end

    def usuario_params
      params.require(:usuario).permit(:email)
    end
end