class Admin::ControlCommandsController < ApplicationController
  layout 'admin'
  before_action :set_control, only: %i[index new create]
  before_action :set_control_command, only: %i[show edit update destroy]

  def index
    @q = @control.control_commands.ransack(params[:q])
    @control_commands = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show; end

  def new
    @control_command = ControlCommand.new
  end

  def edit; end

  def create
    @control_command = @control.control_commands.new(control_command_params)

    if @control_command.save
      redirect_to admin_control_control_commands_path(@control), notice: "#{ControlCommand.model_name.human} criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @control_command.update(control_command_params)
      redirect_to admin_control_command_path(@control_command), notice: "#{ControlCommand.model_name.human} criado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @control_command.destroy
    redirect_to admin_control_control_commands_path(@control), notice: "#{ControlCommand.model_name.human} excluído com sucesso."
  end

  private

  def set_control_command
    @control_command = ControlCommand.find(params[:id])
    @control = @control_command.control
  end

  def set_control
    @control = Control.find(params[:control_id])
  end

  def control_command_params
    params.require(:control_command).permit(:control_id, :code, :command, :active)
  end
end
