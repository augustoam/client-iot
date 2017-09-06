class GruposUsuariosController < ApplicationController
    def index
        grupo_usuario = Usuario.find(current_usuario.id).grupo_usuario
        @grupos_usuarios = Usuario.where(grupo_usuario: grupo_usuario)
        authorize @grupos_usuarios
    end
end