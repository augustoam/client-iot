class ConfirmationsController < Devise::ConfirmationsController
  def show
    if params[:confirmation_token]
      self.resource = resource_class.find_by(confirmation_token: params[:confirmation_token])
      if resource
        if resource.confirmed?
          redirect_to new_usuario_session_path, alert: "Conta já confirmada"
        end
      else
        redirect_to new_usuario_session_path, alert: "Token de confirmação não encontrado"
      end
    else
      redirect_to new_usuario_session_path, alert: "Token de confirmação não encontrado "
    end
  end

  def confirm
    @original_token = params[resource_name].try(:[], :confirmation_token)
    
    self.resource = resource_class.find_by(confirmation_token: @original_token)
    resource.assign_attributes(permitted_params) unless params[resource_name].nil?

    if resource.valid?
      self.resource.confirm
      set_flash_message :notice, :confirmed
      sign_in_and_redirect resource_name, resource
    else
      render :action => 'show'
    end
  end

 private
   def permitted_params
     params.require(resource_name).permit(:confirmation_token, :nome, :password, :password_confirmation)
   end
end
