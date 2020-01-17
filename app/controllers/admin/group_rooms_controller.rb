class Admin::GroupRoomsController < ApplicationController
  layout 'admin'
  before_action :set_group, only: %i[index new create]
  before_action :set_group_room, only: %i[show edit update destroy]

  def index
    @q = @group.group_rooms.ransack(params[:q])
    @group_rooms = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @group_room = GroupRoom.new
  end

  def edit; end

  def create
    @group_room = @group.group_rooms.new(group_room_params)
    if @group_room.save
      redirect_to admin_group_group_rooms_path(@group), notice: "#{GroupRoom.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @group_room.update(group_room_params)
      redirect_to admin_group_room_path(@group_room), notice: "#{GroupRoom.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group_room.destroy
    redirect_to admin_group_group_rooms_path(@group, @group_room), notice: "#{GroupRoom.model_name.human} excluído com sucesso."
  end

  private

  def set_group_room
    @group_room = GroupRoom.find(params[:id])
    @group = @group_room.group
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_room_params
    params.require(:group_room).permit(:name, :room_id, :group_id, :active)
  end
end
