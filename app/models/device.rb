class Device < ApplicationRecord
  validates :name, presence: :true

  def to_s
    self.name.to_s
  end
end
