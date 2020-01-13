class Manufacturer < ApplicationRecord
  has_many :devices
  has_many :controls

  def to_s
    name.to_s
  end
end
