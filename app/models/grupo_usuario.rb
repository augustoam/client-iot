class GrupoUsuario < ApplicationRecord
  has_many :usuarios
  validates :nome, presence: true
end