class Api::V1::GruposController < Api::V1::BaseController

  def get_grupos
    syncinfra = Componente.find_by(descricao: 'SyncInfra')
    @response = usuario_sessao.grupos_usuarios.collect do |grupo_usuario|
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

  def new_grupo   
    grupo = usuario_sessao.grupos.create!(nome: params[:nome])
    render json: grupo.grupos_usuarios.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def edit_grupo

    grupo = usuario_sessao.grupos.find(params[:id]).update(nome: params[:nome])
    render json: grupo.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def destroy_grupo
    usuario_sessao.grupos.find(params[:id]).destroy
    render json: {}, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

end
