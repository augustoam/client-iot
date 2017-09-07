class Usuarios::Devise::ConfirmationsController < Devise::ConfirmationsController
  layout 'login'

  # PUT /resource/confirmation
  def update
    @confirmable = Usuario.find_or_initialize_with_error_by(:confirmation_token, params[:usuario][:confirmation_token])
    if @confirmable
      @confirmable.attempt_set_password(params[:usuario])
      if @confirmable.valid?
        do_confirm
      else
        do_show
      end
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      do_show
    end
  end
  
  protected

  def with_unconfirmed_confirmable
    @confirmable = Usuario.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmable = Usuario.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    @requires_password = true
    self.resource = @confirmable
    render 'usuarios/devise/confirmations/show' #Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end
end
