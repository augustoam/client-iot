class Api::V1::AmbientesController < Api::V1::BaseController
  before_action :authenticate_user

  def new_ambiente
    if @usuario.present?
      begin
        ambiente = Ambiente.find(JSON.parse(params[:ambiente_id]))
        grupo = @usuario.grupos.find(JSON.parse(params[:grupo_id]))
        ambiente_grupo = grupo.ambientes_grupo.create!(nome: ambiente.descricao, icone: ambiente.icone, ambiente: ambiente)
        render json: ambiente_grupo.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def edit_ambiente
    if @usuario.present?
      begin
        ambiente_grupo = AmbienteGrupo.find(JSON.parse(params[:id])).update(nome: JSON.parse(params[:nome]))
        render json: ambiente_grupo.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_ambiente
    if @usuario.present?
      begin
        AmbienteGrupo.find(JSON.parse(params[:id])).destroy
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
