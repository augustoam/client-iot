class GruposUsuariosController < ApplicationController
  before_action :set_grupo, only: [:index]
  
  def index
    @grupos_usuarios = @grupo.usuarios.all 
  end

  private
    def set_grupo
      @grupo = Grupo.find(params[:grupo_id])
    end
end