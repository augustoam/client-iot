class Room < ApplicationRecord
  has_many :rooms_group

  def to_s
    self.name.to_s
  end
end
