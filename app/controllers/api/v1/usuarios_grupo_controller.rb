class Api::V1::UsersGroupController < Api::V1::BaseController
  before_action :authenticate_user

  def add_user_group
    if @user.present?
      user_group = User.find_by(email: params[:email])
      if user_group.present?
        if !GroupUser.find_by(group_id: params[:group_id], user: user_group)
          begin
            group_user = GroupUser.create(group_id: params[:group_id], user: user_group)
            render json: group_user.to_json, status: :ok
          rescue => exception
            render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
          end
        else
          render json: { msg: 'Ops.. este email já pertence a este group!', err: exception }, status: :not_found
        end
      else
        render json: { msg: 'Ops.. este email não pertence a um usuário cadastrado!', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_user_group
    if @user.present?
      begin
        GroupUser.find(params[:id]).destroy
        render json: {}, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def set_admin_user_group
    if @user.present?
      begin
        GroupUser.find(params[:id]).update(admin: params[:admin])
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def authenticate_user
    tokens = params[:tokens]
    @user = User.find_by(token: tokens)
  end
end
