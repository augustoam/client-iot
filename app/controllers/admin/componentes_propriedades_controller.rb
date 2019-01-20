class Admin::ComponentesPropriedadesController < ApplicationController
  layout 'admin'
  before_action :set_componente, only: %i[index new create]
  before_action :set_componente_propriedade, only: %i[show edit update destroy]

  def index
    @q = @componente.componentes_propriedades.ransack(params[:q])
    @componentes_propriedades = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @componente_propriedade = ComponentePropriedade.new
  end

  def edit; end

  def create
    @componente_propriedade = @componente.componentes_propriedades.new(componente_propriedade_params)
    if @componente_propriedade.save
      redirect_to admin_componente_componentes_propriedades_path(@componente), notice: "#{ComponentePropriedade.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @componente_propriedade.update(componente_propriedade_params)
      redirect_to admin_componente_propriedade_path(@componente_propriedade), notice: "#{ComponentePropriedade.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @componente_propriedade.destroy
    redirect_to admin_componente_componentes_propriedades_path(@componente), notice: "#{ComponentePropriedade.model_name.human} excluído com sucesso."
  end

  private

  def set_componente_propriedade
    @componente_propriedade = ComponentePropriedade.find(params[:id])
    @componente = @componente_propriedade.componente
  end

  def set_componente
    @componente = Componente.find(params[:componente_id])
  end

  def componente_propriedade_params
    params.require(:componente_propriedade).permit(:descricao, :value, :id_propriedade, :componente_id)
  end
end
