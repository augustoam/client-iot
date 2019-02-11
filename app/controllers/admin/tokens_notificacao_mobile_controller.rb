class Admin::TokensNotificacaoMobileController < ApplicationController
  layout 'admin'
  before_action :set_usuario, only: [:index, :new, :create]
  before_action :set_token_notificacao_mobile, only: [:show, :edit, :update, :destroy]

  def index
    @tokens_notificacao_mobile = @usuario.tokens_notificacao_mobile.all.paginate(page: params[:page], per_page: params[:per_page] || 35).order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  def new
    @token_notificacao_mobile = @usuario.tokens_notificacao_mobile.new
  end

  def create
    @token_notificacao_mobile = @usuario.tokens_notificacao_mobile.new(token_notificacao_mobile_params)

    if @token_notificacao_mobile.save
      redirect_to admin_usuario_tokens_notificacao_mobile_url(@usuario), notice: 'Token criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @token_notificacao_mobile.update(token_notificacao_mobile_params)
      redirect_to admin_usuario_tokens_notificacao_mobile_url(@usuario), notice: 'Token alterado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @token_notificacao_mobile.destroy
    redirect_to admin_usuario_tokens_notificacao_mobile_url(@usuario), notice: 'Token excluído com sucesso.'
  end

  private

  def set_token_notificacao_mobile
    @token_notificacao_mobile = TokenNotificacaoMobile.find(params[:id])
    @usuario = @token_notificacao_mobile.usuario
  end

  def set_usuario
    @usuario = Usuario.find(params[:usuario_id])
  end

  def token_notificacao_mobile_params
    params.require(:token_notificacao_mobile).permit(:token, :usuario_id)
  end
end
