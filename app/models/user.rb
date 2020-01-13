class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :notification_tokens, dependent: :destroy
  has_many :room_devices, through: :group_rooms
  has_many :group_rooms, through: :group

  validates :email, presence: true, format: { with: Devise::email_regexp }

  # before_create :set_token

  # A callback method used to deliver confirmation
  # instructions on creation. This can be overridden
  # in models to map to a nice sign up e-mail.
  def send_on_create_confirmation_instructions
    # Overridden para não enviar e-mail ao criar um User
    # Ao criar um User o e-mail de confirmation é enviado pelo Job ConvidarUserByEmailJob
  end

  def to_s
    "#{email}"
  end

  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  def password_match?
     self.errors[:password] << "can't be blank" if password.blank?
     self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
     self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
     password == password_confirmation && !password.blank?
  end

  # def set_token
  #   self.token = SecureRandom.hex(64)
  # end
end
