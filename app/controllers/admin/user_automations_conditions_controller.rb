class Admin::AutomacoesGroupCondicoesController < ApplicationController
  layout 'admin'
  before_action :set_automacao_group, only: %i[index new create]
  before_action :set_automacao_group_condicao, only: [:show, :edit, :update, :destroy]
  before_action :repeat_to_s, only: %i[update create]

  def index
    @q = @automacao_group.automacoes_group_condicoes.ransack(params[:q])
    @automacoes_group_condicoes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_group_condicao = UserAutomationCondition.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_group_condicao = @automacao_group.automacoes_group_condicoes.new(automacao_group_condicao_params)
    if @automacao_group_condicao.save
      redirect_to admin_automacao_group_automacoes_group_condicoes_path(@automacao_group), notice: "#{UserAutomationCondition.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_group_condicao.update(automacao_group_condicao_params)
      redirect_to admin_automacao_group_condicao_path(@automacao_group_condicao), notice: "#{UserAutomationCondition.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_group_condicao.destroy
    redirect_to admin_automacao_group_automacoes_group_condicoes_path(@automacao_group, @automacao_group_condicao), notice: "#{UserAutomationCondition.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_group_condicao
      @automacao_group_condicao = UserAutomationCondition.find(params[:id])
      @automacao_group = @automacao_group_condicao.automacao_group
    end

    def set_automacao_group
      @automacao_group = AutomacaoGroup.find(params[:automacao_group_id])
    end

    def repeat_to_s
      params[:automacao_group_condicao][:repeat] = params[:automacao_group_condicao][:repeat].to_json
    end

    def automacao_group_condicao_params
      params.require(:automacao_group_condicao).permit(:tipo_condicao, :value_set, :turn_on, :repeat, :automacao_group_id, :device_room_id, :control_comando_id)
    end
end
