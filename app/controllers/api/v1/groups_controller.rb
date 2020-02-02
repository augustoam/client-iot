class Api::V1::GroupsController < Api::V1::BaseController

  def get_groups
    syncinfra = Device.find_by(name: 'SyncInfra')
    response = []
    user_session.user_groups.collect { |group_user|
      result = {}
      result[:group]      = group_user.group
      result[:groupRooms] = group_user.group.group_rooms.collect do |group_room|
        data = {}
        devices = {}
        data[:groupRoom] = {
          groupRoom: group_room,
          roomDevices:  group_room.room_devices.collect do |room_device|
            devices[:roomDevice] = {
              roomDevice: room_device,
              control: room_device.control,
              device: room_device.control.device
            }
          end
        }
      end
      result[:groupAutomations] = group_user.group.group_automations.collect do |group_automation|
        data = {}
        group_automation_condition = {}
        data[:groupAutomation] = {
          groupAutomation: group_automation,
          groupAutomationCondicoes: group_automation.group_automation_conditions do |group_automation_condition|
            group_automation_condition[:groupAutomationCondition] = {
              groupAutomationCondition: group_automation_condition
            }
          end
        }
      end
      result[:rooms]      = Room.all.order(created_at: :asc)
      result[:devices]    = Device.all.order(created_at: :asc)
      result[:controls]   = Control.where(device: syncinfra)
      result[:userGroups] = group_user.group.users.select('user_groups.*', 'users.email').order(created_at: :asc)
      response << result
    }

    render json: response, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :unauthorized
  end

  def new_group
    group = user_sessao.groups.create!(nome: params[:nome])
    render json: group.user_groups.to_json, status: :ok
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
