class ComponentePolicy < ApplicationPolicy
  class Scope < Scope
    def index?
      usuario.admin?
    end
    def resolve
      scope
    end
  end
end
