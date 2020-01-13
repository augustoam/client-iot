class ControlLayout < ApplicationRecord
  has_many :controls
  validates :descricao, presence: true

  def to_s
    descricao.to_s
  end
end
