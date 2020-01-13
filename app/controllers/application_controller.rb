class ApplicationController < ActionController::Base
  # include Mobylette::RespondToMobileRequests
  include Pundit
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }
  before_action :authenticate_any!, :temperatura
  helper_method :current_user, :log_in

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def current_user
    current_user
    cookies.signed[:user_id] = current_user.id
  end

  def log_in
    cookies.signed[:user_id] = current_user.id
  end

  def temperatura
    @temperatura = ''
    # DeviceRoom
    #   .joins(room: { group: :users })
    #   .where(User.table_name => { id: current_user }, descricao: 'Temperatura')
    #   .each do |device_room|
    #   @temperatura += device_room.room.group.nome + ' ' + device_room.valor.to_s + ' C°'
    # end
  end

  private

  def pundit_user
    current_user
  end

  def user_not_authorized
    flash[:alert] = 'Você não tem autorização'
    redirect_to(request.referrer || root_path)
  end
end
