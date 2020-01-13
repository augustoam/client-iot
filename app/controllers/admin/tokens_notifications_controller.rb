class Admin::TokensNotificationsController < ApplicationController
  layout 'admin'
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_token_notification, only: [:show, :edit, :update, :destroy]

  def index
    @tokens_notifications = @user.tokens_notifications.all.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  def new
    @token_notification = @user.tokens_notifications.new
  end

  def create
    @token_notification = @user.tokens_notifications.new(token_notification_params)

    if @token_notification.save
      redirect_to admin_user_tokens_notifications_url(@user), notice: 'Token criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @token_notification.update(token_notification_params)
      redirect_to admin_user_tokens_notifications_url(@user), notice: 'Token alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @token_notification.destroy
    redirect_to admin_user_tokens_notifications_url(@user), notice: 'Token excluído com sucesso.'
  end

  private

  def set_token_notification
    @token_notification = TokenNotification.find(params[:id])
    @user = @token_notification.user
  end

  def set_user
    @user = user.find(params[:user_id])
  end

  def token_notification_params
    params.require(:token_notification).permit(:token, :user_id)
  end
end
