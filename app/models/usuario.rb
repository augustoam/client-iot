class Usuario < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :grupos_usuarios, dependent: :destroy
  
  # A callback method used to deliver confirmation
  # instructions on creation. This can be overridden
  # in models to map to a nice sign up e-mail.
  #def send_on_create_confirmation_instructions
    # Overridden para não enviar e-mail ao criar um Usuario
    # Ao criar um Usuario o e-mail de confirmation é enviado pelo Job ConvidarUsuarioByEmailJob
  #end

  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
end
