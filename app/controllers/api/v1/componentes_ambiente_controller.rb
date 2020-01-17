class Api::V1::DevicesRoomController < Api::V1::BaseController
  before_action :authenticate_user

  def get_room_devices
    if @user.present?
      begin
        group_room = GroupRoom.find(params[:group_room_id])

        @room_device = group_room.room_devices.collect do |room_device|
          result = room_device.as_json
          result[:device] = room_device.control.device.as_json
          result[:control] = room_device.control.control_layout.as_json
          result[:commands] = room_device.control.comandos_infra_vermelhos.as_json
          result
        end

        render json: @room_device.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_room_device
    if @user.present?

      topico = params[:topico]
      if topico.include? 'synchouse'
        begin
          device = Device.find_by_name(params[:device_name])
          if params[:device_id].present?
            control = Control.find(params[:device_id])
          else
            control = Control.find_by(device: device)
          end

          room_device = RoomDevice.create!(
            name: device.name,
            topico: topico,
            control: control,
            group_room_id: params[:group_room_id],
            identificador_device: topico)
          render json: room_device.to_json, status: :ok
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

  def edit_room_device
    if @user.present?
      begin
        room_device = RoomDevice.find(params[:room_device_id]).update(name: params[:name])
        render json: room_device.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_room_device
    if @user.present?
      begin
        RoomDevice.find(params[:room_device_id]).destroy
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
