class Admin::AutomacoesGrupoCondicoesController < ApplicationController
  layout 'admin'
  before_action :set_automacao_grupo, only: %i[index new create]
  before_action :set_automacao_grupo_condicao, only: [:show, :edit, :update, :destroy]
  before_action :repeat_to_s, only: %i[update create]

  def index
    @q = @automacao_grupo.automacoes_grupo_condicoes.ransack(params[:q])
    @automacoes_grupo_condicoes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_grupo_condicao = AutomacaoGrupoCondicao.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_grupo_condicao = @automacao_grupo.automacoes_grupo_condicoes.new(automacao_grupo_condicao_params)
    if @automacao_grupo_condicao.save
      redirect_to admin_automacao_grupo_automacoes_grupo_condicoes_path(@automacao_grupo), notice: "#{AutomacaoGrupoCondicao.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_grupo_condicao.update(automacao_grupo_condicao_params)
      redirect_to admin_automacao_grupo_condicao_path(@automacao_grupo_condicao), notice: "#{AutomacaoGrupoCondicao.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_grupo_condicao.destroy
    redirect_to admin_automacao_grupo_automacoes_grupo_condicoes_path(@automacao_grupo, @automacao_grupo_condicao), notice: "#{AutomacaoGrupoCondicao.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_grupo_condicao
      @automacao_grupo_condicao = AutomacaoGrupoCondicao.find(params[:id])
      @automacao_grupo = @automacao_grupo_condicao.automacao_grupo
    end

    def set_automacao_grupo
      @automacao_grupo = AutomacaoGrupo.find(params[:automacao_grupo_id])
    end

    def repeat_to_s
      params[:automacao_grupo_condicao][:repeat] = params[:automacao_grupo_condicao][:repeat].to_json
    end

    def automacao_grupo_condicao_params
      params.require(:automacao_grupo_condicao).permit(:tipo_condicao, :value_set, :turn_on, :repeat, :automacao_grupo_id, :componente_ambiente_id, :controle_comando_id)
    end
end
