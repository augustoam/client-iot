class Admin::AmbientesGrupoController < ApplicationController
  layout 'admin'
  before_action :set_grupo, only: %i[index new create]
  before_action :set_ambiente_grupo, only: %i[show edit update destroy]

  def index
    @q = @grupo.ambientes_grupo.ransack(params[:q])
    @ambientes_grupo = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @ambiente_grupo = AmbienteGrupo.new
  end

  def edit; end

  def create
    @ambiente_grupo = @grupo.ambientes_grupo.new(ambiente_grupo_params)
    if @ambiente_grupo.save
      redirect_to admin_grupo_ambientes_grupo_path(@grupo), notice: "#{AmbienteGrupo.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @ambiente_grupo.update(ambiente_grupo_params)
      redirect_to admin_ambiente_grupo_path(@ambiente_grupo), notice: "#{AmbienteGrupo.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @ambiente_grupo.destroy
    redirect_to admin_grupo_ambientes_grupo_path(@grupo, @ambiente_grupo), notice: "#{AmbienteGrupo.model_name.human} excluído com sucesso."
  end

  private

  def set_ambiente_grupo
    @ambiente_grupo = AmbienteGrupo.find(params[:id])
    @grupo = @ambiente_grupo.grupo
  end

  def set_grupo
    @grupo = Grupo.find(params[:grupo_id])
  end

  def ambiente_grupo_params
    params.require(:ambiente_grupo).permit(:nome, :icone, :visivel, :ambiente_id, :grupo_id)
  end
end
