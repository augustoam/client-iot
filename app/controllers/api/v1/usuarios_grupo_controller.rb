class Api::V1::UsuariosGrupoController < Api::V1::BaseController
  before_action :authenticate_user

  def add_usuario_grupo
    if @usuario.present?
      usuario_grupo = Usuario.find_by(email: JSON.parse(params[:email]))
      if usuario_grupo.present?
        if !GrupoUsuario.find_by(grupo_id: JSON.parse(params[:grupo_id]), usuario: usuario_grupo)
          begin
            GrupoUsuario.create(grupo_id: JSON.parse(params[:grupo_id]), usuario: usuario_grupo)
            render json: usuario_grupo.to_json, status: :ok
          rescue => exception
            render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
          end
        else
          render json: { msg: 'Ops.. este email já pertence a este grupo!', err: exception }, status: :not_found
        end
      else
        render json: { msg: 'Ops.. este email não pertence a um usuário cadastrado!', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_usuario_grupo
    if @usuario.present?
      begin
        GrupoUsuario.find_by(usuario_id: JSON.parse(params[:usuario_id]), grupo_id: JSON.parse(params[:grupo_id])).destroy
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
