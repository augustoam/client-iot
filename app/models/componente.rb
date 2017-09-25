class Componente < ApplicationRecord
  belongs_to :ambiente
  belongs_to :controle_componente

  def to_s
    "#{descricao}"
  end
end
