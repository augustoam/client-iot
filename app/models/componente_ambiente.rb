class ComponenteAmbiente < ApplicationRecord
  belongs_to :ambiente
  belongs_to :componente

  # after_save { ComponenteAmbienteBroadcastJob.perform_later self }
  def to_s
    descricao.to_s
  end
end
