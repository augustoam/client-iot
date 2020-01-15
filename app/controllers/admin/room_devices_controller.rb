class Admin::DevicesRoomController < ApplicationController
  layout 'admin'
  before_action :set_room_group, only: %i[index new create]
  before_action :set_device_room, only: %i[show edit update destroy]

  def index
    @q = @room_group.devices_room.ransack(params[:q])
    @devices_room = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @device_room = DeviceRoom.new
  end

  def edit; end

  def create
    @device_room = @room_group.devices_room.new(device_room_params)
    if @device_room.save
      redirect_to admin_room_group_devices_room_path(@room_group), notice: "#{DeviceRoom.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @device_room.update(device_room_params)
      redirect_to admin_device_room_path(@device_room), notice: "#{DeviceRoom.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @device_room.destroy
    redirect_to admin_room_group_devices_room_path(@room_group), notice: "#{DeviceRoom.model_name.human} excluído com sucesso."
  end

  private

  def set_device_room
    @device_room = DeviceRoom.find(params[:id])
    @room_group = @device_room.room_group
  end

  def set_room_group
    @room_group = RoomGroup.find(params[:room_group_id])
  end

  def device_room_params
    params.require(:device_room).permit(:name, :topico, :topico_info1, :info1,
                                                :topico_info2, :info2, :topico_info3, :info3,
                                                :topico_result, :result, :topico_state, :state,
                                                :topico_power, :power, :topico_online, :onlline,
                                                :identificador_device, :control_id, :room_group_id)
  end
end
