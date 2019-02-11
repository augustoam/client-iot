class Api::V1::AmbientesController < Api::V1::BaseController
  before_action :authenticate_user

  def new_ambiente
    ambiente = Ambiente.find(params[:ambiente_id])
    grupo = @usuario.grupos.find(params[:grupo_id])
    ambiente_grupo = grupo.ambientes_grupo.create!(nome: ambiente.descricao, icone: ambiente.icone, ambiente: ambiente)
    render json: ambiente_grupo.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def edit_ambiente
    ambiente_grupo = AmbienteGrupo.find(params[:id]).update(nome: params[:nome])
    render json: ambiente_grupo.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def destroy_ambiente
    AmbienteGrupo.find(params[:id]).destroy
    render json: {}, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end
end
