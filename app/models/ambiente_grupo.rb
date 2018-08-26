class AmbienteGrupo < ApplicationRecord
  belongs_to :grupo
  belongs_to :ambiente
  has_many :componentes_ambiente, dependent: :destroy

  def to_s
    nome.to_s
  end
end
