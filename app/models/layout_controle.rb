class LayoutControle < ApplicationRecord
  has_many :componentes
  validates :descricao, presence: true

  def to_s
    descricao.to_s
  end
end
