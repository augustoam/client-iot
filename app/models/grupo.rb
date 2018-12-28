class Grupo < ApplicationRecord
  has_many :grupos_usuarios, dependent: :destroy
  has_many :usuarios, through: :grupos_usuarios
  has_many :ambientes_grupo, dependent: :destroy
  has_many :log_componentes
  has_many :automacoes_grupo

  validates :nome, presence: true

  def to_s
    nome.to_s
  end
end
