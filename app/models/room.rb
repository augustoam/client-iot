class Room < ApplicationRecord
  has_many :rooms_group

  def to_s
    descricao.to_s
  end
end
