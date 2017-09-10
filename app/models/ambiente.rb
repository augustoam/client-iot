class Ambiente < ApplicationRecord
  belongs_to :grupo
  has_many :componentes
end
