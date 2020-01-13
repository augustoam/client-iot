class Api::V1::DevicesRoomController < Api::V1::BaseController
  before_action :authenticate_user

  def get_devices_room
    if @user.present?
      begin
        room_group = RoomGroup.find(params[:room_group_id])

        @device_room = room_group.devices_room.collect do |device_room|
          result = device_room.as_json
          result[:device] = device_room.control.device.as_json
          result[:control] = device_room.control.layout_control.as_json
          result[:comandos] = device_room.control.comandos_infra_vermelhos.as_json
          result
        end

        render json: @device_room.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end

  def new_device_room
    if @user.present?

      topico = params[:topico]
      if topico.include? 'synchouse'
        begin
          device = Device.find_by_descricao(params[:device_descricao])
          if params[:device_id].present?
            control = Control.find(params[:device_id])
          else
            control = Control.find_by(device: device)
          end

          device_room = DeviceRoom.create!(
            descricao: device.descricao,
            topico: topico,
            control: control,
            room_group_id: params[:room_group_id],
            identificador_device: topico)
          render json: device_room.to_json, status: :ok
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

  def edit_device_room
    if @user.present?
      begin
        device_room = DeviceRoom.find(params[:device_room_id]).update(descricao: params[:descricao])
        render json: device_room.to_json, status: :ok
      rescue => exception
        render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
      end
    else
      render json: { msg: 'Usuário não autorizado!' }, status: :unprocessable_entity
    end
  end

  def destroy_device_room
    if @user.present?
      begin
        DeviceRoom.find(params[:device_room_id]).destroy
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
