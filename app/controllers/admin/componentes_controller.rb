class Admin::ComponentesController < ApplicationController
  layout 'admin'
  before_action :set_ambiente, only: [:index, :new, :create]
  before_action :set_componente, only: [:show, :edit, :update, :destroy]

  def index
    @q = Componente.ransack(params[:q])
    @componentes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def new
    @componente = Componente.new
  end

  def edit
  end

  def create
    @componente = @ambiente.componentes.new(componente_params)
    if @componente.save
      redirect_to admin_grupo_ambiente_componentes_path(@ambiente.grupo, @ambiente), notice: "#{Componente.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @componente.update(componente_params)
      redirect_to admin_grupo_ambiente_componente_path(@ambiente.grupo, @ambiente, @componente), notice: "#{Componente.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @componente.destroy
    redirect_to admin_grupo_ambiente_componentes_path(@ambiente.grupo, @ambiente), notice: "#{Componente.model_name.human} excluído com sucesso."
  end

  private
    def set_componente
      @componente = Componente.find(params[:id])
      @ambiente = @componente.ambiente
    end

    def set_ambiente
      @ambiente = Ambiente.find(params[:ambiente_id])
    end

    def componente_params
      params.require(:componente).permit(:descricao, :topico, :ambiente_id)
    end
end
