class Admin::FabricantesController < ApplicationController
  layout 'admin'
  before_action :set_fabricante, only: %i[show edit update destroy]

  def index
    @q = Fabricante.ransack(params[:q])
    @fabricantes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @fabricante = Fabricante.new
  end

  def edit; end

  def show; end

  def create
    @fabricante = Fabricante.new(fabricante_params)

    if @fabricante.save
      redirect_to [:admin, @fabricante], notice: "#{Fabricante.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @fabricante.update(fabricante_params)
      redirect_to admin_fabricante_path(@fabricante), notice: "#{Fabricante.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @fabricante.destroy
    redirect_to admin_fabricantes_url, notice: "#{Fabricante.model_name.human} excluído com sucesso."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_fabricante
    @fabricante = Fabricante.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fabricante_params
    params.fetch(:fabricante).permit(:descricao, :obs)
  end
end
