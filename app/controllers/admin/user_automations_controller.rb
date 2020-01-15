class Admin::AutomacoesGroupController < ApplicationController
  layout 'admin'
  before_action :set_group, only: %i[index new create]
  before_action :set_automacao_group, only: [:show, :edit, :update, :destroy]

  def index
    @q = AutomacaoGroup.ransack(params[:q])
    @automacoes_group = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @automacao_group = AutomacaoGroup.new
  end

  def edit
  end

  def show
  end

  def create
    @automacao_group = @group.automacoes_group.new(automacao_group_params)
    if @automacao_group.save
      redirect_to admin_group_automacoes_group_path(@group), notice: "#{AutomacaoGroup.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @automacao_group.update(automacao_group_params)
      redirect_to admin_automacao_group_path(@automacao_group), notice: "#{AutomacaoGroup.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @automacao_group.destroy
    redirect_to admin_group_automacoes_group_path(@group, @automacao_group), notice: "#{AutomacaoGroup.model_name.human} excluído com sucesso."
  end

  private
    def set_automacao_group
      @automacao_group = AutomacaoGroup.find(params[:id])
      @group = @automacao_group.group
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def automacao_group_params
      params.require(:automacao_group).permit(:name, :ativo, :tipo, :operador_condicao)
    end
end
