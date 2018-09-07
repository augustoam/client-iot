class Api::V1::GruposController < Api::V1::BaseController
  before_action :authenticate_user

  def get_grupos
    if @usuario.present?
      begin
        @response = @usuario.grupos_usuarios.collect do |grupo_usuario|
          result = grupo_usuario.as_json
          result[:grupo] = grupo_usuario.grupo
          result[:ambientes_grupo] = grupo_usuario.grupo.ambientes_grupo
          result[:ambientes] = Ambiente.all
          result[:componentes] = Componente.all
          result[:usuarios_grupo] = grupo_usuario.grupo.usuarios
          result
        end
        render json: @response.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_grupo
    if @usuario.present?
      begin
        grupo = @usuario.grupos.create!(nome: JSON.parse(params[:nome]))
        render json: grupo.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def edit_grupo
    if @usuario.present?
      begin
        grupo = @usuario.grupos.find(JSON.parse(params[:id])).update(nome: JSON.parse(params[:nome]))
        render json: grupo.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_grupo
    if @usuario.present?
      begin
        @usuario.grupos.find(JSON.parse(params[:id])).destroy
        render json: {}, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def authenticate_user
    tokens = JSON.parse(params[:tokens])
    @usuario = Usuario.find_by(token: tokens)
  end
end
