class Api::V1::ComponentesAmbienteController < Api::V1::BaseController
  before_action :authenticate_user

  def get_componentes_ambiente
    if @usuario.present?
      begin
        ambiente_grupo = AmbienteGrupo.find(params[:ambiente_grupo_id])

        @componente_ambiente = ambiente_grupo.componentes_ambiente.collect do |componente_ambiente|
          result = componente_ambiente.as_json
          result[:componente] = componente_ambiente.controle.componente.as_json
          result[:comandos] = componente_ambiente.controle.comandos_infra_vermelhos.as_json
          result
        end

        render json: @componente_ambiente.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_componente_ambiente
    if @usuario.present?

      topico = params[:topico]
      if topico.include? 'synchouse'
        begin
          componente = Componente.find_by_descricao(params[:componente_descricao])
          if params[:controle_id].present?
            controle = Controle.find(params[:controle_id])
          else
            controle = Controle.find_by(componente: componente)
          end

          componente_ambiente = ComponenteAmbiente.create!(
            descricao: componente.descricao,
            topico: topico,
            controle: controle,
            ambiente_grupo_id: params[:ambiente_grupo_id])
          render json: componente_ambiente.to_json, status: :ok
        rescue => exception
          render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
        end
      else
        render json: { msg: 'QRCode inválido. Tente novamente!' }, status: :unprocessable_entity
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def edit_componente_ambiente
    if @usuario.present?
      begin
        componente_ambiente = ComponenteAmbiente.find(params[:componente_ambiente_id]).update(descricao: params[:descricao])
        render json: componente_ambiente.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_componente_ambiente
    if @usuario.present?
      begin
        ComponenteAmbiente.find(params[:componente_ambiente_id]).destroy
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
