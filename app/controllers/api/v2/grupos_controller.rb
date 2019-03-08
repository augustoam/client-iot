class Api::V2::GruposController < Api::V2::BaseController

  def get_grupos
    syncinfra = Componente.find_by(descricao: 'SyncInfra')
    response = []
    usuario_sessao.grupos_usuarios.collect { |grupo_usuario|
      result = {}
      result[:grupo]           = grupo_usuario.grupo
      result[:ambientes_grupo] = grupo_usuario.grupo.ambientes_grupo.collect do |ambiente_grupo|
        data = {}
        data[:ambiente_grupo] = {
          ambiente_grupo: ambiente_grupo,
          componentes_ambiente:  ambiente_grupo.componentes_ambiente
        }
      end
      result[:ambientes]       = Ambiente.all.order(created_at: :asc)
      result[:componentes]     = Componente.all.order(created_at: :asc)
      result[:controles]       = Controle.where(componente: syncinfra)
      result[:usuarios_grupo]  = grupo_usuario.grupo.usuarios.select('grupos_usuarios.*', 'usuarios.email').order(created_at: :asc)
      response << result
    }
    # grupos = {
    #   grupos: @response[0][:grupo],
    #   ambientes_grupo: @response[0][:ambientes_grupo],
    #   ambientes: @response[0][:ambientes],
    #   componentes: @response[0][:componentes],
    #   controles: @response[0][:controles],
    #   usuarios_grupo: @response[0][:usuarios_grupo]
    # }
    render json: response, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :unauthorized
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
