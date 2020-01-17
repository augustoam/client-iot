class Room < ApplicationRecord
  has_many :group_rooms

  def to_s
    self.name.to_s
  end
end
