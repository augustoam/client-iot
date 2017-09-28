class Componente < ApplicationRecord
  belongs_to :ambiente
  belongs_to :controle_componente
  has_many :comandos_infra_vermelhos

  def to_s
    "#{descricao}"
  end
end
