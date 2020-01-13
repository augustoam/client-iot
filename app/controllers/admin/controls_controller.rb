class Admin::ControlsController < ApplicationController
  layout 'admin'
  before_action :set_control, only: %i[show edit update destroy]

  def index
    @q = Control.ransack(params[:q])
    @controls = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @control = Control.new
  end

  def create
    @control = Control.new(control_params)

    if @control.save
      redirect_to [:admin, @control], notice: "#{Control.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @control.update(control_params)
      redirect_to admin_controls_path(@control), notice: "#{Control.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @control.destroy
    redirect_to admin_controls_url, notice: "#{Control.model_name.human} excluído com sucesso."
  end

  private

  def set_control
    @control = Control.find(params[:id])
  end

  def control_params
    params.require(:control).permit(:descricao, :obs, :manufacturer_id, :layout_control_id, :device_id)
  end
end
