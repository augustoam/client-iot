class Admin::ControlComandosController < ApplicationController
  layout 'admin'
  before_action :set_control, only: %i[index new create]
  before_action :set_control_comando, only: %i[show edit update destroy]

  def index
    @q = @control.control_comandos.ransack(params[:q])
    @control_comandos = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @control_comando = ControlComando.new
  end

  def edit; end

  def create
    @control_comando = @control.control_comandos.new(control_comando_params)

    if @control_comando.save
      redirect_to admin_control_control_comandos_path(@control), notice: "#{ControlComando.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @control_comando.update(control_comando_params)
      redirect_to admin_control_comando_path(@control_comando), notice: "#{ControlComando.model_name.human} criado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @control_comando.destroy
    redirect_to admin_control_control_comandos_path(@control), notice: "#{ControlComando.model_name.human} excluído com sucesso."
  end

  private

  def set_control_comando
    @control_comando = ControlComando.find(params[:id])
    @control = @control_comando.control
  end

  def set_control
    @control = Control.find(params[:control_id])
  end

  def control_comando_params
    params.require(:control_comando).permit(:control_id, :codigo, :comando)
  end
end
