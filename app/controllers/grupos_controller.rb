class GruposController < ApplicationController
  def index
    @grupos = current_usuario.grupos_usuarios
    #authorize @grupos
  end
end

# current_usuario.grupos_usuarios.inclue? @grupo
