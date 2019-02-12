class ControleComando < ApplicationRecord
  belongs_to :controle

  def to_s
    comando.to_s
  end
end
