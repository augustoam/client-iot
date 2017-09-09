class Admin::GruposController < ApplicationController
  layout 'admin'
  before_action :set_grupo, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = Grupo.ransack(params[:q])
    @grupos = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @grupo = Grupo.new
  end

  def edit
  end

  def show
  end

  def create
    @grupo = Grupo.new(grupo_params)

    if @grupo.save
      redirect_to [:admin, @grupo], notice: "#{Grupo.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @grupo.update(grupo_params)
      redirect_to admin_grupo_path(@grupo), notice: "#{Grupo.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @grupo.destroy
    redirect_to admin_grupos_url, notice: "#{Grupo.model_name.human} excluído com sucesso."
  end
  
  private
    def set_grupo
      @grupo = Grupo.find(params[:id])
    end

    def grupo_params
      params.require(:grupo).permit(:nome)
    end
end