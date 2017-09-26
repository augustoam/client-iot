class Admin::AdministradorController < ApplicationController
  layout 'admin'
  before_action :set_administrador, only: [:edit]

  def edit
    @admin = current_admin
  end

  def update
    @admin = Admin.find(params[:id])
    @admin.attempt_set_password(params[:admin])
    if @admin.valid? && @admin.password_match?
      redirect_to admin_path, notice: "Senha alterada com sucesso"
    else
      redirect_to edit_admin_administrador_path, notice: "Senha inválida."
    end
  end
  private

  def set_administrador
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :admin)
  end

end
