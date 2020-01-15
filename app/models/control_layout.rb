class ControlLayout < ApplicationRecord
  has_many :controls
  validates :name, presence: true

  def to_s
    self.name.to_s
  end
end
