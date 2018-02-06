class Ambiente < ApplicationRecord
  belongs_to :grupo
  has_many :componentes_ambiente

  def to_s
    nome.to_s
  end
end
