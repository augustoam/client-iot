class Admin::DevicesController < ApplicationController
  layout 'admin'
  before_action :set_device, only: %i[show edit update destroy]

  def index
    @q = Device.ransack(params[:q])
    @devices = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @device = Device.new
  end

  def edit; end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to admin_devices_path, notice: "#{Device.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @device.update(device_params)
      redirect_to admin_device_path(@device), notice: "#{Device.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @device.destroy
    redirect_to admin_devices_path, notice: "#{Device.model_name.human} excluído com sucesso."
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:descricao, :modelo, :comando_unico, :url_icone, :identificador_device)
  end
end
