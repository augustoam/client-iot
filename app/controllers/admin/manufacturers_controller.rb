class Admin::ManufacturersController < ApplicationController
  layout 'admin'
  before_action :set_manufacturer, only: %i[show edit update destroy]

  def index
    @q = Manufacturer.ransack(params[:q])
    @manufacturers = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit; end

  def show; end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      redirect_to [:admin, @manufacturer], notice: "#{Manufacturer.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @manufacturer.update(manufacturer_params)
      redirect_to admin_manufacturer_path(@manufacturer), notice: "#{Manufacturer.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @manufacturer.destroy
    redirect_to admin_manufacturers_url, notice: "#{Manufacturer.model_name.human} excluído com sucesso."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def manufacturer_params
    params.fetch(:manufacturer).permit(:name, :obs, :active)
  end
end
