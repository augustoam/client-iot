class Fabricante < ApplicationRecord
  has_many :componentes
  has_many :controles

  def to_s
    descricao.to_s
  end
end
