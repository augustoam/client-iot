class ComandoInfraVermelho < ApplicationRecord
  belongs_to :componente

  def to_s
    "#{comando}"
  end
end
