class ApplicationController < ActionController::Base
  # include Mobylette::RespondToMobileRequests
  include Pundit
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }
  before_action :authenticate_any!, :temperatura
  helper_method :current_user, :log_in

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_any!
    true
    # if admin_signed_in?
    #   true
    # else
    #   authenticate_usuario!
    # end
  end

  def current_user
    current_usuario
    cookies.signed[:user_id] = current_usuario.id
  end

  def log_in
    cookies.signed[:user_id] = current_usuario.id
  end

  def temperatura
    @temperatura = ''
    ComponenteAmbiente
      .joins(ambiente: { grupo: :usuarios })
      .where(Usuario.table_name => { id: current_usuario }, descricao: 'Temperatura')
      .each do |componente_ambiente|
      @temperatura += componente_ambiente.ambiente.grupo.nome + ' ' + componente_ambiente.valor.to_s + ' C°'
    end
  end

  private

  def pundit_user
    current_usuario
  end

  def user_not_authorized
    flash[:alert] = 'Você não tem autorização'
    redirect_to(request.referrer || root_path)
  end
end
