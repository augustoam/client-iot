class Api::V1::RoomsController < Api::V1::BaseController
  before_action :authenticate_user

  def new_room
    room = Room.find(params[:room_id])
    group = @user.groups.find(params[:group_id])
    group_room = group.group_rooms.create!(nome: room.name, icone: room.icone, room: room)
    render json: group_room.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def edit_room
    group_room = GroupRoom.find(params[:id]).update(nome: params[:nome])
    render json: group_room.to_json, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end

  def destroy_room
    GroupRoom.find(params[:id]).destroy
    render json: {}, status: :ok
  rescue => exception
    render json: { msg: 'Ops.. parece que aconteceu um problema =(', err: exception }, status: :not_found
  end
end
