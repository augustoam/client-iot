class Api::V2::GroupsController < Api::V2::BaseController

  def get_groups
    syncinfra = Device.find_by(descricao: 'SyncInfra')
    response = []
    user_sessao.groups_users.collect { |group_user|
      result = {}
      result[:group]           = group_user.group
      result[:rooms_group] = group_user.group.rooms_group.collect do |room_group|
        data = {}
        devices = {}
        data[:room_group] = {
          room_group: room_group,
          devices_room:  room_group.devices_room.collect do |device_room|
            devices[:device_room] = {
              device_room: device_room,
              control: device_room.control,
              device: device_room.control.device
            }
          end
        }
      end
      result[:automacoes_group] = group_user.group.automacoes_group.collect do |automacao_group|
        data = {}
        automacao_group_condicao = {}
        data[:automacao_group] = {
          automacao_group: automacao_group,
          automacao_group_condicoes: automacao_group.automacoes_group_condicoes do |automacao_group_condicao|
            automacao_group_condicao[:automacao_group_condicao] = {
              automacao_group_condicao: automacao_group_condicao
            }
          end
        }
      end
      result[:rooms]         = Room.all.order(created_at: :asc)
      result[:devices]       = Device.all.order(created_at: :asc)
      result[:controls]         = Control.where(device: syncinfra)
      result[:users_group]    = group_user.group.users.select('groups_users.*', 'users.email').order(created_at: :asc)
      response << result
    }
    render json: response, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :unauthorized
  end

  def new_group
    group = user_sessao.groups.create!(nome: params[:nome])
    render json: group.groups_users.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def edit_group
    group = user_sessao.groups.find(params[:id]).update(nome: params[:nome])
    render json: group.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def destroy_group
    user_sessao.groups.find(params[:id]).destroy
    render json: {}, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

end
