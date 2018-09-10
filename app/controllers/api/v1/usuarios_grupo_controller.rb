class Api::V1::UsuariosGrupoController < Api::V1::BaseController
  before_action :authenticate_user

  def add_usuario_grupo
    if @usuario.present?
      usuario_grupo = Usuario.find_by(email: params[:email])
      if usuario_grupo.present?
        if !GrupoUsuario.find_by(grupo_id: params[:grupo_id], usuario: usuario_grupo)
          begin
            grupo_usuario = GrupoUsuario.create(grupo_id: params[:grupo_id], usuario: usuario_grupo)
            render json: grupo_usuario.to_json, status: :ok
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
        GrupoUsuario.find(params[:id]).destroy
        render json: {}, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def set_admin_usuario_grupo
    if @usuario.present?
      begin
        GrupoUsuario.find(params[:id]).update(admin: params[:admin])
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
