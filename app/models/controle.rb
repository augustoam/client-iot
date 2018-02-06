class Controle < ApplicationRecord
  has_many :comandos_infra_vermelhos
  has_many :componentes
  belongs_to :fabricante
  validates :descricao, presence: true

  def to_s
    descricao.to_s
  end
end
