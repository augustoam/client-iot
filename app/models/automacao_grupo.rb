class AutomacaoGrupo < ApplicationRecord
  belongs_to :grupo
  has_many :automacoes_grupo_condicoes

  def to_s
    self.descricao
  end
end
