class Admin::ControleComandosController < ApplicationController
  layout 'admin'
  before_action :set_controle, only: %i[index new create]
  before_action :set_controle_comando, only: %i[show edit update destroy]

  def index
    @q = @controle.controle_comandos.ransack(params[:q])
    @controle_comandos = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @controle_comando = ControleComando.new
  end

  def edit; end

  def create
    @controle_comando = @controle.controle_comandos.new(controle_comando_params)

    if @controle_comando.save
      redirect_to admin_controle_controle_comandos_path(@controle), notice: "#{ControleComando.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @controle_comando.update(controle_comando_params)
      redirect_to admin_controle_comando_path(@controle_comando), notice: "#{ControleComando.model_name.human} criado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @controle_comando.destroy
    redirect_to admin_controle_controle_comandos_path(@controle), notice: "#{ControleComando.model_name.human} excluído com sucesso."
  end

  private

  def set_controle_comando
    @controle_comando = ControleComando.find(params[:id])
    @controle = @controle_comando.controle
  end

  def set_controle
    @controle = Controle.find(params[:controle_id])
  end

  def controle_comando_params
    params.require(:controle_comando).permit(:controle_id, :codigo, :comando)
  end
end
