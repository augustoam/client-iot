class ComponenteAmbiente < ApplicationRecord
  belongs_to :ambiente_grupo
  belongs_to :componente

  validates :topico, :descricao, presence: true
  # after_save { ComponenteAmbienteBroadcastJob.perform_later self }
  def to_s
    descricao.to_s
  end
end
