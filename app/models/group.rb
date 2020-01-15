class Group < ApplicationRecord
  has_many :groups_users, dependent: :destroy
  has_many :users, through: :groups_users
  has_many :rooms_group, dependent: :destroy
  has_many :log_devices
  has_many :automacoes_group

  validates :name, presence: true

  def to_s
    self.name.to_s
  end
end
