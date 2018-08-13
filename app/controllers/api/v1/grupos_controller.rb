class Api::V1::GruposController < Api::V1::BaseController

  def get_grupos
    tokens = JSON.parse(params['tokens'])
    usuarios = Usuario.where(token: tokens)
    if usuarios.any?
      usuarios.each do |usuario|

        @ambientes = usuario.grupos_usuarios.collect do |grupo_usuario|
          result = grupo_usuario.as_json
          result[:grupo] = grupo_usuario.grupo
          result[:ambientes] = grupo_usuario.grupo.ambientes.where(visivel: true)
          result
        end
      end
      render json: @ambientes.to_json, status: :ok
    else
      render json: { msg: 'Usuário não autorizado, verifique sua conta!' }, status: :unprocessable_entity
    end
  end
end
