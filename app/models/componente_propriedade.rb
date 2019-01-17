class ComponentePropriedade < ApplicationRecord
  belongs_to :componente
  has_many :automacoes_grupo_acoes
  has_many :automacoes_grupo_condicoes

  def to_s
    descricao
  end
end
