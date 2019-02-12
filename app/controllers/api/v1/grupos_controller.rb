class Api::V1::GruposController < Api::V1::BaseController
  before_action :authenticate_user

  def get_grupos
    if @usuario.present?
      begin
        syncinfra = Componente.find_by(descricao: 'SyncInfra')
        @response = @usuario.grupos_usuarios.collect do |grupo_usuario|
          result = grupo_usuario.as_json
          result[:grupo]           = grupo_usuario.grupo
          result[:ambientes_grupo] = grupo_usuario.grupo.ambientes_grupo.order(created_at: :asc)
          result[:ambientes]       = Ambiente.all.order(created_at: :asc)
          result[:componentes]     = Componente.all.order(created_at: :asc)
          result[:controles]       = Controle.where(componente: syncinfra)
          result[:usuarios_grupo]  = grupo_usuario.grupo.usuarios.select('grupos_usuarios.*', 'usuarios.email').order(created_at: :asc)
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
        grupo = @usuario.grupos.create!(nome: params[:nome])
        render json: grupo.grupos_usuarios.to_json, status: :ok
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
        grupo = @usuario.grupos.find(params[:id]).update(nome: params[:nome])
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
        @usuario.grupos.find(params[:id]).destroy
        render json: {}, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def authenticate_user
    tokens = params[:tokens]
    @usuario = Usuario.find_by(token: tokens)
  end
end