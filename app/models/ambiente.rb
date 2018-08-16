class Ambiente < ApplicationRecord
  has_many :ambientes_grupo

  def to_s
    descricao.to_s
  end
end
