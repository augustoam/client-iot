class Grupo < ApplicationRecord
  has_many :grupos_usuarios, dependent: :destroy
  validates :nome, presence: true
end
