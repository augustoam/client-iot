class Room < ApplicationRecord
  has_many :group_rooms

  def to_s
    name.to_s
  end
end
