class AutomacaoGrupo < ApplicationRecord
  belongs_to :grupo

  def to_s
    self.descricao
  end
end
