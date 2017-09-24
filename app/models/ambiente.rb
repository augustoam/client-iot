class Ambiente < ApplicationRecord
  belongs_to :grupo
  has_many :componentes

  def to_s
    "#{nome}"
  end
end
