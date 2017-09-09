module UsuarioPolicy
  def index?
    user.admin?
  end
end