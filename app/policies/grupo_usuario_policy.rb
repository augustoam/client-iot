class GrupoUsuarioPolicy < ApplicationPolicy
  def index?
    usuario.admin?
  end
  # 
  # def show?
  #   current_usuario.grupos_usuarios.incluse? record
  # end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
