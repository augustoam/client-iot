class Admin::ControlesController < ApplicationController
  layout 'admin'
  before_action :set_controle, only: %i[show edit update destroy]

  def index
    @q = Controle.ransack(params[:q])
    @controles = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @controle = Controle.new
  end

  def create
    @controle = Controle.new(controle_params)

    if @controle.save
      redirect_to [:admin, @controle], notice: "#{Controle.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @controle.update(controle_params)
      redirect_to admin_controles_path(@controle), notice: "#{Controle.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @controle.destroy
    redirect_to admin_controles_url, notice: "#{Controle.model_name.human} excluído com sucesso."
  end

  private

  def set_controle
    @controle = Controle.find(params[:id])
  end

  def controle_params
    params.require(:controle).permit(:descricao, :obs, :fabricante_id, :layout_controle_id, :componente_id)
  end
end
