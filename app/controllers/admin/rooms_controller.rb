class Admin::RoomsController < ApplicationController
  layout 'admin'
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @q = Room.ransack(params[:q])
    @rooms = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to admin_rooms_path, notice: "#{Room.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to admin_room_path(@room), notice: "#{Room.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_path(@room), notice: "#{Room.model_name.human} excluído com sucesso."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :obs, :active)
  end
end
