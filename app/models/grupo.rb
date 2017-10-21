class Grupo < ApplicationRecord
  has_many :grupos_usuarios, dependent: :destroy
  has_many :usuarios, through: :grupos_usuarios
  has_many :ambientes
  has_many :log_componentes
  validates :nome, presence: true

  def to_s
    "#{nome}"
  end
end
