class Api::V1::RoomsController < Api::V1::BaseController
  before_action :authenticate_user

  def new_room
    room = Room.find(params[:room_id])
    group = @user.groups.find(params[:group_id])
    room_group = group.rooms_group.create!(nome: room.descricao, icone: room.icone, room: room)
    render json: room_group.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def edit_room
    room_group = RoomGroup.find(params[:id]).update(nome: params[:nome])
    render json: room_group.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def destroy_room
    RoomGroup.find(params[:id]).destroy
    render json: {}, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end
end
