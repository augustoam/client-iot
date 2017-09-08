class Usuario < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :grupos_usuarios, dependent: :destroy
  has_many :grupos, through: :grupos_usuarios 

  validates :email, presence: true, format: { with: Devise::email_regexp }
  
  # A callback method used to deliver confirmation
  # instructions on creation. This can be overridden
  # in models to map to a nice sign up e-mail.
  def send_on_create_confirmation_instructions
    # Overridden para não enviar e-mail ao criar um Usuario
    # Ao criar um Usuario o e-mail de confirmation é enviado pelo Job ConvidarUsuarioByEmailJob
  end

end
