class Admin::RoomsGroupController < ApplicationController
  layout 'admin'
  before_action :set_group, only: %i[index new create]
  before_action :set_room_group, only: %i[show edit update destroy]

  def index
    @q = @group.rooms_group.ransack(params[:q])
    @rooms_group = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @room_group = RoomGroup.new
  end

  def edit; end

  def create
    @room_group = @group.rooms_group.new(room_group_params)
    if @room_group.save
      redirect_to admin_group_rooms_group_path(@group), notice: "#{RoomGroup.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @room_group.update(room_group_params)
      redirect_to admin_room_group_path(@room_group), notice: "#{RoomGroup.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @room_group.destroy
    redirect_to admin_group_rooms_group_path(@group, @room_group), notice: "#{RoomGroup.model_name.human} excluído com sucesso."
  end

  private

  def set_room_group
    @room_group = RoomGroup.find(params[:id])
    @group = @room_group.group
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def room_group_params
    params.require(:room_group).permit(:nome, :icone, :visivel, :room_id, :group_id)
  end
end
