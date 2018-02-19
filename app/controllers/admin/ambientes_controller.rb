class Admin::AmbientesController < ApplicationController
  layout 'admin'
  before_action :set_grupo, only: %i[index new create]
  before_action :set_ambiente, only: %i[show edit update destroy]

  def index
    @q = @grupo.ambientes.ransack(params[:q])
    @ambientes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @ambiente = Ambiente.new
  end

  def edit; end

  def create
    @ambiente = @grupo.ambientes.new(ambiente_params)
    if @ambiente.save
      redirect_to admin_grupo_ambientes_path(@grupo), notice: "#{Ambiente.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @ambiente.update(ambiente_params)
      redirect_to admin_ambiente_path(@ambiente), notice: "#{Ambiente.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @ambiente.destroy
    redirect_to admin_grupo_ambientes_path(@grupo, @ambiente), notice: "#{Ambiente.model_name.human} excluído com sucesso."
  end

  private

  def set_ambiente
    @ambiente = Ambiente.find(params[:id])
    @grupo = @ambiente.grupo
  end

  def set_grupo
    @grupo = Grupo.find(params[:grupo_id])
  end

  def ambiente_params
    params.require(:ambiente).permit(:nome, :icone, :visivel, :grupo_id)
  end
end
