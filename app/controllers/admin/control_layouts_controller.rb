class Admin::ControlLayoutsController < ApplicationController
  layout 'admin'
  before_action :set_control_layout, only: %i[show edit update destroy]

  def index
    @q = ControlLayout.ransack(params[:q])
    @control_layouts = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @control_layout = ControlLayout.new
  end

  def create
    debugger
    @control_layout = ControlLayout.new(control_layout_params)

    if @control_layout.save
      redirect_to [:admin, @control_layout], notice: "#{ControlLayout.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @control_layout.update(control_layout_params)
      redirect_to admin_control_layout_path(@control_layout), notice: "#{ControlLayout.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @control_layout.destroy
    redirect_to admin_control_layouts_url, notice: "#{ControlLayout.model_name.human} excluído com sucesso."
  end

  private

  def set_control_layout
    @control_layout = ControlLayout.find(params[:id])
  end

  def control_layout_params
    params.require(:control_layout).permit(:name, :type_name, :obs, :active, :manufacturer_id)
  end
end
