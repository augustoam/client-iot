class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :group_rooms, dependent: :destroy
  has_many :log_devices
  has_many :group_automations

  validates :name, presence: true

  def to_s
    name.to_s
  end
end
