class Admin::ComandosInfraVermelhosController < ApplicationController
  layout 'admin'
  before_action :set_controle, only: %i[index new create]
  before_action :set_comando_infra_vermelho, only: %i[show edit update destroy]

  def index
    @q = @controle.comandos_infra_vermelhos.ransack(params[:q])
    @comandos_infra_vermelhos = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @comando_infra_vermelho = ComandoInfraVermelho.new
  end

  def edit; end

  def create
    @comando_infra_vermelho = @controle.comandos_infra_vermelhos.new(comando_infra_vermelho_params)

    if @comando_infra_vermelho.save
      redirect_to admin_controle_comandos_infra_vermelhos_path(@controle), notice: "#{ComandoInfraVermelho.model_name.human} criado com sucesso"
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
    redirect_to admin_controle_comandos_infra_vermelhos_path(@controle), notice: "#{ComandoInfraVermelho.model_name.human} excluído com sucesso."
  end

  private

  def set_comando_infra_vermelho
    @comando_infra_vermelho = ComandoInfraVermelho.find(params[:id])
    @controle = @comando_infra_vermelho.controle
  end

  def set_controle
    @controle = Controle.find(params[:controle_id])
  end

  def comando_infra_vermelho_params
    params.require(:comando_infra_vermelho).permit(:controle_id, :codigo, :comando)
  end
end
