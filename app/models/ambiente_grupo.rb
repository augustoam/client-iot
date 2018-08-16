class AmbienteGrupo < ApplicationRecord
  belongs_to :grupo
  belongs_to :ambiente
  has_many :componentes_ambiente

  def to_s
    nome.to_s
  end
end
