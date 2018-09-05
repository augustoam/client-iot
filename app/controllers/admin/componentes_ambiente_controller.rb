class Admin::ComponentesAmbienteController < ApplicationController
  layout 'admin'
  before_action :set_ambiente_grupo, only: %i[index new create]
  before_action :set_componente_ambiente, only: %i[show edit update destroy]

  def index
    @q = @ambiente_grupo.componentes_ambiente.ransack(params[:q])
    @componentes_ambiente = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @componente_ambiente = ComponenteAmbiente.new
  end

  def edit; end

  def create
    @componente_ambiente = @ambiente_grupo.componentes_ambiente.new(componente_ambiente_params)
    if @componente_ambiente.save
      redirect_to admin_ambiente_grupo_componentes_ambiente_path(@ambiente_grupo), notice: "#{ComponenteAmbiente.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @componente_ambiente.update(componente_ambiente_params)
      redirect_to admin_componente_ambiente_path(@componente_ambiente), notice: "#{ComponenteAmbiente.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @componente_ambiente.destroy
    redirect_to admin_ambiente_grupo_componentes_ambiente_path(@ambiente_grupo), notice: "#{ComponenteAmbiente.model_name.human} excluído com sucesso."
  end

  private

  def set_componente_ambiente
    @componente_ambiente = ComponenteAmbiente.find(params[:id])
    @ambiente_grupo = @componente_ambiente.ambiente_grupo
  end

  def set_ambiente_grupo
    @ambiente_grupo = AmbienteGrupo.find(params[:ambiente_grupo_id])
  end

  def componente_ambiente_params
    params.require(:componente_ambiente).permit(:descricao, :topico, :identificador_componente, :componente_id, :ambiente_grupo_id)
  end
end
