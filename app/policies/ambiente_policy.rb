class AmbientePolicy < ApplicationPolicy
  def index?
    usuario.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
