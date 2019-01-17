class AutomacaoGrupo < ApplicationRecord
  belongs_to :grupo
  has_many :automacoes_grupo_condicoes
  has_many :automacoes_grupo_acoes

  def to_s
    self.descricao
  end
end
