class Admin::LayoutControlesController < ApplicationController
  layout 'admin'
  before_action :set_layout_controle, only: %i[show edit update destroy]

  def index
    @q = LayoutControle.ransack(params[:q])
    @layout_controles = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @layout_controle = LayoutControle.new
  end

  def create
    @layout_controle = LayoutControle.new(layout_controle_params)

    if @layout_controle.save
      redirect_to [:admin, @layout_controle], notice: "#{LayoutControle.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @layout_controle.update(layout_controle_params)
      redirect_to admin_layout_controle_path(@layout_controle), notice: "#{LayoutControle.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @layout_controle.destroy
    redirect_to admin_layout_controles_url, notice: "#{LayoutControle.model_name.human} excluído com sucesso."
  end

  private

  def set_layout_controle
    @layout_controle = LayoutControle.find(params[:id])
  end

  def layout_controle_params
    params.require(:layout_controle).permit(:descricao, :tipo_layout, :obs, :fabricante_id)
  end
end
