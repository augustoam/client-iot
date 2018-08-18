class Api::V1::GruposController < Api::V1::BaseController
  before_action :authenticate_user

  def get_grupos
    if @usuario.present?
      @ambientes = []
      @ambientes = @usuario.grupos_usuarios.collect do |grupo_usuario|
        result = grupo_usuario.as_json
        result[:grupo] = grupo_usuario.grupo
        result[:ambientes_grupo] = grupo_usuario.grupo.ambientes_grupo
        result
      end
      render json: @ambientes.to_json, status: :ok
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_grupo
    if @usuario.present?
      grupo = @usuario.grupos.create!(nome: JSON.parse(params[:nome]))
      render json: grupo.to_json, status: :ok
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def edit_grupo
    if @usuario.present?
      grupo = @usuario.grupos.find(JSON.parse(params[:id])).update(nome: JSON.parse(params[:nome]))
      render json: grupo.to_json, status: :ok
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_grupo
    if @usuario.present?
      @usuario.grupos.find(JSON.parse(params[:id])).destroy
      render json: {}, status: :ok
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def authenticate_user
    tokens = JSON.parse(params[:tokens])
    @usuario = Usuario.find_by(token: tokens)
  end
end
