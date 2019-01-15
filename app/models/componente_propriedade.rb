class ComponentePropriedade < ApplicationRecord
  belongs_to :componente

  def to_s
    descricao
  end
end
