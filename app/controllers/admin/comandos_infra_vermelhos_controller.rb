class Admin::ComandosInfraVermelhosController < ApplicationController
  layout 'admin'
  before_action :set_componente, only: [:index, :new, :create]
  before_action :set_comando_infra_vermelho, only: [:show, :edit, :update, :destroy]

  def index
    @q = @componente.comandos_infra_vermelhos.ransack(params[:q])
    @comandos_infra_vermelhos = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def new
    @comando_infra_vermelho = ComandoInfraVermelho.new
  end

  def edit
  end

  def create
    @comando_infra_vermelho = @componente.comandos_infra_vermelhos.new(comando_infra_vermelho_params)

    if @comando_infra_vermelho.save
      redirect_to admin_componente_comandos_infra_vermelhos_path(@componente), notice: "#{ComandoInfraVermelho.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @comando_infra_vermelho.update(comando_infra_vermelho_params)
      redirect_to admin_comando_infra_vermelho_path(@comando_infra_vermelho), notice: "#{ComandoInfraVermelho.model_name.human} criado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @comando_infra_vermelho.destroy
    redirect_to admin_componente_comandos_infra_vermelhos_path(@componente), notice: "#{ComandoInfraVermelho.model_name.human} excluído com sucesso."
  end

  private
    def set_comando_infra_vermelho
      @comando_infra_vermelho = ComandoInfraVermelho.find(params[:id])
      @componente = @comando_infra_vermelho.componente
    end

    def set_componente
      @componente = Componente.find(params[:componente_id])
    end

    def comando_infra_vermelho_params
      params.require(:comando_infra_vermelho).permit(:componente_id, :topico, :comando, :html)
    end
end
