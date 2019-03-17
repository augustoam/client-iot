class Api::V2::GruposController < Api::V2::BaseController

  def get_grupos
    syncinfra = Componente.find_by(descricao: 'SyncInfra')
    response = []
    usuario_sessao.grupos_usuarios.collect { |grupo_usuario|
      result = {}
      result[:grupo]           = grupo_usuario.grupo
      result[:ambientes_grupo] = grupo_usuario.grupo.ambientes_grupo.collect do |ambiente_grupo|
        data = {}
        componentes = {}
        data[:ambiente_grupo] = {
          ambiente_grupo: ambiente_grupo,
          componentes_ambiente:  ambiente_grupo.componentes_ambiente.collect do |componente_ambiente|
            componentes[:componente_ambiente] = {
              componente_ambiente: componente_ambiente,
              controle: componente_ambiente.controle,
              componente: componente_ambiente.controle.componente
            }
          end
        }
      end
      result[:automacoes_grupo] = grupo_usuario.grupo.automacoes_grupo.collect do |automacao_grupo|
        data = {}
        automacao_grupo_condicao = {}
        data[:automacao_grupo] = {
          automacao_grupo: automacao_grupo,
          automacao_grupo_condicoes: automacao_grupo.automacoes_grupo_condicoes do |automacao_grupo_condicao|
            automacao_grupo_condicao[:automacao_grupo_condicao] = {
              automacao_grupo_condicao: automacao_grupo_condicao
            }
          end
        }
      end
      result[:ambientes]         = Ambiente.all.order(created_at: :asc)
      result[:componentes]       = Componente.all.order(created_at: :asc)
      result[:controles]         = Controle.where(componente: syncinfra)
      result[:usuarios_grupo]    = grupo_usuario.grupo.usuarios.select('grupos_usuarios.*', 'usuarios.email').order(created_at: :asc)
      response << result
    }
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
