class GruposController < ApplicationController
  def index
    @grupos = current_usuario.grupos_usuarios
  end
end
