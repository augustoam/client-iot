class Admin::AutomacoesGroupAcoesController < ApplicationController
  layout 'admin'

  before_action :set_automacao_group, only: %i[index new create]
  before_action :set_automacao_group_acao, only: [:show, :edit, :update, :destroy]

  def index
    @q = @automacao_group.automacoes_group_acoes.ransack(params[:q])
    @automacoes_group_acoes = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_group_acao = AutomacaoGroupAcao.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_group_acao = @automacao_group.automacoes_group_acoes.new(automacao_group_acao_params)
    if @automacao_group_acao.save
      redirect_to admin_automacao_group_automacoes_group_acoes_path(@automacao_group), notice: "#{AutomacaoGroupAcao.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_group_acao.update(automacao_group_acao_params)
      redirect_to admin_automacao_group_acao_path(@automacao_group_acao), notice: "#{AutomacaoGroupAcao.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_group_acao.destroy
    redirect_to admin_automacao_group_automacoes_group_acoes_path(@automacao_group, @automacao_group_acao), notice: "#{AutomacaoGroupAcao.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_group_acao
      @automacao_group_acao = AutomacaoGroupAcao.find(params[:id])
      @automacao_group = @automacao_group_acao.automacao_group
    end

    def set_automacao_group
      @automacao_group = AutomacaoGroup.find(params[:automacao_group_id])
    end

    def set_devices_rooms
      @devices_rooms = DeviceRoom.all
    end

    def automacao_group_acao_params
      params.require(:automacao_group_acao).permit(:tipo_acao, :delay_time, :run_automacao_id, :turn_on_off_automation_id, :turn_on_off,
                                                   :automacao_group_id, :device_room_id, :control_comando_id)
    end
end
