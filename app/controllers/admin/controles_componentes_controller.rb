class Admin::ControlesComponentesController < ApplicationController
  layout 'admin'
  before_action :set_controle_componente, only: [:show, :edit, :update, :destroy]

  def index
    @q = ControleComponente.ransack(params[:q])
    @controles_componentes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  def new
    @controle_componente = ControleComponente.new
  end

  def create
    @controle_componente = ControleComponente.new(controle_componente_params)

    if @controle_componente.save
      redirect_to [:admin, @controle_componente], notice: "#{ControleComponente.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @controle_componente.update(controle_componente_params)
      redirect_to admin_controles_componentes_path(@controle_componente), notice: "#{ControleComponente.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @controle_componente.destroy
    redirect_to admin_controles_componentes_url, notice: "#{ControleComponente.model_name.human} excluído com sucesso."
  end

  private

  def set_controle_componente
    @controle_componente = ControleComponente.find(params[:id])
  end

  def controle_componente_params
    params.require(:controle_componente).permit(:descricao, :obs)
  end

end
