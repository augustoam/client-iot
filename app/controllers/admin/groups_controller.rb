class Admin::GroupsController < ApplicationController
  layout 'admin'
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @q = Group.ransack(params[:q])
    @groups = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def show
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to [:admin, @group], notice: "#{Group.model_name.human} criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to admin_group_path(@group), notice: "#{Group.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_url, notice: "#{Group.model_name.human} excluído com sucesso."
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :active)
    end
end
