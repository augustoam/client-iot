class Admin::AutomacoesGrupoAcoesController < ApplicationController
  layout 'admin'

  before_action :set_automacao_grupo, only: %i[index new create]
  before_action :set_automacao_grupo_acao, only: [:show, :edit, :update, :destroy]

  def index
    @q = @automacao_grupo.automacoes_grupo_acoes.ransack(params[:q])
    @automacoes_grupo_acoes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_grupo_acao = AutomacaoGrupoAcao.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_grupo_acao = @automacao_grupo.automacoes_grupo_acoes.new(automacao_grupo_acao_params)
    if @automacao_grupo_acao.save
      redirect_to admin_automacao_grupo_automacoes_grupo_acoes_path(@automacao_grupo), notice: "#{AutomacaoGrupoAcao.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_grupo_acao.update(automacao_grupo_acao_params)
      redirect_to admin_automacao_grupo_acao_path(@automacao_grupo_acao), notice: "#{AutomacaoGrupoAcao.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_grupo_acao.destroy
    redirect_to admin_automacao_grupo_automacoes_grupo_acoes_path(@automacao_grupo, @automacao_grupo_acao), notice: "#{AutomacaoGrupoAcao.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_grupo_acao
      @automacao_grupo_acao = AutomacaoGrupoAcao.find(params[:id])
      @automacao_grupo = @automacao_grupo_acao.automacao_grupo
    end

    def set_automacao_grupo
      @automacao_grupo = AutomacaoGrupo.find(params[:automacao_grupo_id])
    end

    def set_componentes_ambientes
      @componentes_ambientes = ComponenteAmbiente.all
    end

    def automacao_grupo_acao_params
      params.require(:automacao_grupo_acao).permit(:tipo_acao, :delay_time, :run_automacao_id, :turn_on_off_automation_id, :turn_on_off,
                                                   :automacao_grupo_id, :componente_ambiente_id, :controle_comando_id)
    end
end
