class GruposController < ApplicationController
  def index
    @grupos_usuarios = current_usuario.grupos_usuarios
  end
end
