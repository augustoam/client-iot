class Api::V1::GroupsController < Api::V1::BaseController
  before_action :authenticate_user

  def get_groups
    if @user.present?
      begin
        syncinfra = Device.find_by(name: 'SyncInfra')
        @response = @user.groups_users.collect do |group_user|
          result = group_user.as_json
          result[:group]           = group_user.group
          result[:rooms_group] = group_user.group.rooms_group.order(created_at: :asc)
          result[:rooms]       = Room.all.order(created_at: :asc)
          result[:devices]     = Device.all.order(created_at: :asc)
          result[:controls]       = Control.where(device: syncinfra)
          result[:users_group]  = group_user.group.users.select('groups_users.*', 'users.email').order(created_at: :asc)
          result
        end
        render json: @response.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_group
    if @user.present?
      begin
        group = @user.groups.create!(nome: params[:nome])
        render json: group.groups_users.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def edit_group
    if @user.present?
      begin
        group = @user.groups.find(params[:id]).update(nome: params[:nome])
        render json: group.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_group
    if @user.present?
      begin
        @user.groups.find(params[:id]).destroy
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
    @user = User.find_by(token: tokens)
  end
end