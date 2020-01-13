class GroupUserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
  # 
  # def show?
  #   current_user.groups_users.incluse? record
  # end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
