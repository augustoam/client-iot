class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :set_group, only: [:index, :new, :create, :edit, :show, :update, :destroy, :remover]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :remover]

  def index_all
    @q = User.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def index
    @q = @group.users.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def create
    if params[:user]
      @group_user = @group.user_groups.new
      @user = User.find_by(email: params[:user][:email])
      if @user
        if @group.users.include?(@user)
          redirect_to admin_group_users_path(@group), alert: "Usuário #{@user.email} já pertence a esse group"
        else
          @group_user.user = @user
          @group_user.save
          redirect_to admin_group_users_path(@group), alert: "Usuário #{@user.email} vinculado a este group"
        end
      else
        password = Devise.friendly_token.first(8)
        @user = User.create!(email: params[:user][:email], password: password, admin: params[:user][:admin])
        @group_user.user = @user
        @group_user.save

        ConvidarUserByEmailJob.perform_later(@user)

        redirect_to admin_group_users_path(@group), notice: "Usuário criado com sucesso"
      end
    else
      render :new, alert: "Informe um e-mail válido"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_group_users_path(@group, @user), notice: "#{User.model_name.human} alterado com sucesso."
    else
      render :edit
    end
  end

  def remover
    group_user = UserGroup.find_by(group_id: @group, user_id: @user)
    group_user.destroy
    redirect_to admin_group_users_path(@group), notice: "#{User.model_name.human} removido do group com sucesso."
  end

  def destroy
    @user.destroy
    redirect_to admin_group_users_path(@group), notice: "#{User.model_name.human} excluído com sucesso."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def user_params
      params.require(:user).permit(:email, :admin)
    end
end
