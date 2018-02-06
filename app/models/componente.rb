class Componente < ApplicationRecord
  belongs_to :fabricante
  belongs_to :controle
  belongs_to :layout_controle
  has_many :log_componentes

  validates :controle, presence: :true
  validates :fabricante, presence: :true
  validates :layout_controle, presence: :true
  validates :descricao, presence: :true

  def to_s
    descricao.to_s
  end
end
