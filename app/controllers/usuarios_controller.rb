class UsersController < ApplicationController
  include ControllerResponder
  before_action :set_group, only: [:index, :destroy, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = @group.users.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def password_change
    @user = User.find(params[:user_id])
  end

  def password_update
    @user = User.find(params[:user_id])
    @user.attempt_set_password(params[:user])
    if @user.valid? && @user.password_match?
      redirect_to user_path(@user), notice: "Senha alterada com sucesso"
    else
      redirect_to user_password_change_path(@user), notice: "Senha inválida."
    end
  end

  def create
    if params[:user]
      @group = Group.find(params[:user][:group_id])
      @group_user = @group.groups_users.new

      @user = User.find_by(email: params[:user][:email])
      if @user
        if @group.users.include?(@user)
          redirect_to group_users_path(@group), alert: "Usuário #{@user.email} já é administrador deste group"
        end
      else
        password = Devise.friendly_token.first(8)
        @user = User.create!(email: params[:user][:email], password: password)
        @group_user.user = @user
        @group_user.save

        ConvidarUserByEmailJob.perform_later(@user)

        redirect_to group_users_path(@group), notice: "Usuário criado com sucesso"
      end
    else
      redirect_to group_path(@group), alert: "Informe um e-mail válido"
    end
  end

  def update
    @user.assign_attributes(user_params.except(:password, :password_confirmation))
    if(!user_params[:password].to_s.empty?) && user_params[:password].to_s != @user.password
      @user.password = user_params[:password]
      @user.password_confirmation = user_params[:password_confirmation]
    end
    @user.save
    redirect_to group_users_path(@group), notice: "Usuário alterado com sucesso"
  end

  def destroy
    @user.destroy
    redirect_to group_users_path(@group), notice: "Usuário removido com sucesso"
  end


  private
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :admin)
    end

end
