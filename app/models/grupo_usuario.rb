class GrupoUsuario < ApplicationRecord
  belongs_to :grupo
  belongs_to :usuario

  before_create :set_admin

  def set_admin
    self.admin = true
  end
end
