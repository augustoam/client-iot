class Admin::GroupAutomationActionsController < ApplicationController
  layout 'admin'

  before_action :set_group_automation, only: %i[index new create]
  before_action :set_group_automation_action, only: [:show, :edit, :update, :destroy]

  def index
    @q = @group_automation.group_automation_actions.ransack(params[:q])
    @group_automation_actions = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @group_automation_action = GroupAutomationAction.new
  end

  def edit
  end

  def show
  end

  def create
    @group_automation_action = @group_automation.group_automation_actions.new(group_automation_action_params)
    if @group_automation_action.save
      redirect_to admin_group_automation_group_automation_actions_path(@group_automation), notice: "#{GroupAutomationAction.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @group_automation_action.update(group_automation_action_params)
      redirect_to admin_group_automation_action_path(@group_automation_action), notice: "#{GroupAutomationAction.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group_automation_action.destroy
    redirect_to admin_group_automation_group_automation_actions_path(@group_automation, @group_automation_action), notice: "#{GroupAutomationAction.model_name.human} excluído com sucesso."
  end

  private
    def set_group_automation_action
      @group_automation_action = GroupAutomationAction.find(params[:id])
      @group_automation = @group_automation_action.group_automation
    end

    def set_group_automation
      @group_automation = GroupAutomation.find(params[:group_automation_id])
    end

    def set_room_devicess
      @room_devicess = RoomDevice.all
    end

    def group_automation_action_params
      params.require(:group_automation_action).permit(:type_action, :delay_time, :run_automation_id, :turn_on_off_automation_id, :turn_on_off,
                                                      :group_automation_id, :room_device_id, :control_command_id, :active)
    end
end
