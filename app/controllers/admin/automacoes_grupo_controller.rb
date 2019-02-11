class Admin::AutomacoesGrupoController < ApplicationController
  layout 'admin'
  before_action :set_grupo, only: %i[index new create]
  before_action :set_automacao_grupo, only: [:show, :edit, :update, :destroy]

  def index
    @q = AutomacaoGrupo.ransack(params[:q])
    @automacoes_grupo = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_grupo = AutomacaoGrupo.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_grupo = @grupo.automacoes_grupo.new(automacao_grupo_params)
    if @automacao_grupo.save
      redirect_to admin_grupo_automacoes_grupo_path(@grupo), notice: "#{AutomacaoGrupo.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_grupo.update(automacao_grupo_params)
      redirect_to admin_automacao_grupo_path(@automacao_grupo), notice: "#{AutomacaoGrupo.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_grupo.destroy
    redirect_to admin_grupo_automacoes_grupo_path(@grupo, @automacao_grupo), notice: "#{AutomacaoGrupo.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_grupo
      @automacao_grupo = AutomacaoGrupo.find(params[:id])
      @grupo = @automacao_grupo.grupo
    end

    def set_grupo
      @grupo = Grupo.find(params[:grupo_id])
    end

    def automacao_grupo_params
      params.require(:automacao_grupo).permit(:descricao, :ativo, :tipo, :operador_condicao)
    end
end
