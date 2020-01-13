class Admin::ControlLayoutsController < ApplicationController
  layout 'admin'
  before_action :set_layout_control, only: %i[show edit update destroy]

  def index
    @q = ControlLayout.ransack(params[:q])
    @layout_controls = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @layout_control = ControlLayout.new
  end

  def create
    @layout_control = ControlLayout.new(layout_control_params)

    if @layout_control.save
      redirect_to [:admin, @layout_control], notice: "#{ControlLayout.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @layout_control.update(layout_control_params)
      redirect_to admin_layout_control_path(@layout_control), notice: "#{ControlLayout.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @layout_control.destroy
    redirect_to admin_layout_controls_url, notice: "#{ControlLayout.model_name.human} excluído com sucesso."
  end

  private

  def set_layout_control
    @layout_control = ControlLayout.find(params[:id])
  end

  def layout_control_params
    params.require(:layout_control).permit(:descricao, :tipo_layout, :obs, :manufacturer_id)
  end
end
