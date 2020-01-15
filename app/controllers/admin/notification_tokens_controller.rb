class Admin::NotificationTokensController < ApplicationController
  layout 'admin'
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_notification_token, only: [:show, :edit, :update, :destroy]

  def index
    @notification_tokens = @user.notification_tokens.all.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  def new
    @notification_token = @user.notification_tokens.new
  end

  def create
    @notification_token = @user.notification_tokens.new(notification_token_params)

    if @notification_token.save
      redirect_to admin_user_notification_tokens_url(@user), notice: 'Token criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @notification_token.update(notification_token_params)
      redirect_to admin_user_notification_tokens_url(@user), notice: 'Token alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @notification_token.destroy
    redirect_to admin_user_notification_tokens_url(@user), notice: 'Token excluído com sucesso.'
  end

  private

  def set_notification_token
    @notification_token = NotificationToken.find(params[:id])
    @user = @notification_token.user
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def notification_token_params
    params.require(:notification_token).permit(:token, :user_id, :active)
  end
end
