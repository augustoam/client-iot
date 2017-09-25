class ControleComponente < ApplicationRecord
  has_many :componentes

  validates :descricao, presence: true

  def to_s
    "#{descricao}"    
  end
end
