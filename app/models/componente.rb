class Componente < ApplicationRecord
  has_many :log_componentes

  validates :descricao, presence: :true

  def to_s
    descricao.to_s
  end
end
