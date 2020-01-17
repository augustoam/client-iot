class GroupRoom < ApplicationRecord
  belongs_to :group
  belongs_to :room
  has_many :room_devices, dependent: :destroy

  def to_s
    self.name.to_s
  end
end
