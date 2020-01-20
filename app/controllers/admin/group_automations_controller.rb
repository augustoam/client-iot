class Admin::GroupAutomationsController < ApplicationController
  layout 'admin'
  before_action :set_group, only: %i[index new create]
  before_action :set_group_automation, only: [:show, :edit, :update, :destroy]

  def index
    @q = GroupAutomation.ransack(params[:q])
    @group_automations = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @group_automation = GroupAutomation.new
  end

  def edit
  end

  def show
  end

  def create
    @group_automation = @group.group_automations.new(group_automation_params)
    if @group_automation.save
      redirect_to admin_group_group_automations_path(@group), notice: "#{GroupAutomation.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @group_automation.update(group_automation_params)
      redirect_to admin_group_automation_path(@group_automation), notice: "#{GroupAutomation.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group_automation.destroy
    redirect_to admin_group_group_automations_path(@group, @group_automation), notice: "#{GroupAutomation.model_name.human} excluído com sucesso."
  end

  private
    def set_group_automation
      @group_automation = GroupAutomation.find(params[:id])
      @group = @group_automation.group
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def group_automation_params
      params.require(:group_automation).permit(:name, :active, :condition_operator)
    end
end
