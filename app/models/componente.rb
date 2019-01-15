class Componente < ApplicationRecord
  has_many :log_componentes
  has_many :componentes_propriedades

  validates :descricao, presence: :true

  def to_s
    descricao.to_s
  end
end
