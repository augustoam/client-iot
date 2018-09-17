class LayoutControle < ApplicationRecord
  has_many :controles
  validates :descricao, presence: true

  def to_s
    descricao.to_s
  end
end
