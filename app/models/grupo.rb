class Grupo < ApplicationRecord
  has_many :grupos_usuarios, dependent: :destroy
  has_many :usuarios, through: :grupos_usuarios
  validates :nome, presence: true
end
