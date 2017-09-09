class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_action :authenticate_usuario! 
  include Pundit

  def current_user
    current_usuario
  end

  private
    def pundit_user
      current_usuario
    end

end
