class Admin::RoomDevicesController < ApplicationController
  layout 'admin'
  before_action :set_group_room, only: %i[index new create]
  before_action :set_room_device, only: %i[show edit update destroy]

  def index
    @q = @group_room.room_devices.ransack(params[:q])
    @room_devices = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @room_device = RoomDevice.new
  end

  def edit; end

  def create
    @room_device = @group_room.room_devices.new(room_device_params)
    if @room_device.save
      redirect_to admin_group_room_room_devices_path(@group_room), notice: "#{RoomDevice.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @room_device.update(room_device_params)
      redirect_to admin_room_device_path(@room_device), notice: "#{RoomDevice.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @room_device.destroy
    redirect_to admin_group_room_room_devices_path(@group_room), notice: "#{RoomDevice.model_name.human} excluído com sucesso."
  end

  private

  def set_room_device
    @room_device = RoomDevice.find(params[:id])
    @group_room = @room_device.group_room
  end

  def set_group_room
    @group_room = GroupRoom.find(params[:group_room_id])
  end

  def room_device_params
    params.require(:room_device).permit(:name, :topic_info1, :info1,
                                        :topic_info2, :info2, :topic_info3, :info3,
                                        :topic_result, :result, :topic_state, :state,
                                        :topic_power, :power, :topic_online, :online,
                                        :control_id, :topic_id, :sensor_value, :group_room_id)
  end
end
