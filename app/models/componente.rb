class Componente < ApplicationRecord
  belongs_to :ambiente

  def to_s
    "#{descricao}"
  end
end
