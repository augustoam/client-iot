class Api::V1::ComponentesAmbienteController < Api::V1::BaseController

  def get_componentes_ambiente
    tokens = JSON.parse(params['tokens'])
    usuarios = Usuario.where(token: tokens)
    if usuarios.any?
      usuarios.each do |usuario|
        ambiente_grupo = AmbienteGrupo.find(params['ambiente_grupo_id'])

        @componente_ambiente = ambiente_grupo.componentes_ambiente.collect do |componente_ambiente|
          result = componente_ambiente.as_json
          result[:layout_controle] = componente_ambiente.componente.layout_controle.as_json
          result
        end
      end
      render json: @componente_ambiente.to_json, status: :ok
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end
end
