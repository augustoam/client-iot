class Grupo < ApplicationRecord
  has_many :grupos_usuarios, dependent: :destroy
  has_many :usuarios, through: :grupos_usuarios
  has_many :ambientes_grupo
  has_many :log_componentes

  validates :nome, presence: true

  def to_s
    nome.to_s
  end
end
