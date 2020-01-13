module UserPolicy
  def index?
    user.admin?
  end
end