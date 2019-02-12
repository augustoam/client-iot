class Controle < ApplicationRecord
  has_many :controle_comandos
  belongs_to :layout_controle
  belongs_to :componente
  belongs_to :fabricante
  validates :descricao, presence: true

  def to_s
    descricao.to_s
  end
end
