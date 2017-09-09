class Admin::Devise::SessionsController < Devise::SessionsController
  layout 'admin'

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end