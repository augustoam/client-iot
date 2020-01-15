class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :rooms_group, dependent: :destroy
  has_many :log_devices
  has_many :automacoes_group

  validates :name, presence: true

  def to_s
    self.name.to_s
  end
end
