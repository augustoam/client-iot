class Admin::GroupAutomationConditionsController < ApplicationController
  layout 'admin'
  before_action :set_group_automation, only: %i[index new create]
  before_action :set_group_automation_condition, only: [:show, :edit, :update, :destroy]
  before_action :repeat_to_s, only: %i[update create]

  def index
    @q = @group_automation.group_automation_conditions.ransack(params[:q])
    @group_automation_conditions = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @group_automation_condition = GroupAutomationCondition.new
  end

  def edit
  end

  def show
  end

  def create
    @group_automation_condition = @group_automation.group_automation_conditions.new(group_automation_condition_params)
    if @group_automation_condition.save
      redirect_to admin_group_automation_group_automation_conditions_path(@group_automation), notice: "#{GroupAutomationCondition.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @group_automation_condition.update(group_automation_condition_params)
      redirect_to admin_group_automation_condition_path(@group_automation_condition), notice: "#{GroupAutomationCondition.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group_automation_condition.destroy
    redirect_to admin_group_automation_group_automation_conditions_path(@group_automation, @group_automation_condition), notice: "#{GroupAutomationCondition.model_name.human} excluído com sucesso."
  end

  private
    def set_group_automation_condition
      @group_automation_condition = GroupAutomationCondition.find(params[:id])
      @group_automation = @group_automation_condition.group_automation
    end

    def set_group_automation
      @group_automation = GroupAutomation.find(params[:group_automation_id])
    end

    def repeat_to_s
      params[:group_automation_condition][:repeat] = params[:group_automation_condition][:repeat].to_json
    end

    def group_automation_condition_params
      params.require(:group_automation_condition).permit(:type_condition, :value_set, :turn_on, :repeat, :group_automation_id, :room_device_id, :control_command_id)
    end
end
