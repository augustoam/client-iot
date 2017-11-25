# class ComponenteBroadcastJob < ApplicationJob
#   queue_as :default
#
#     def perform(componente)
#       #debugger
#       ActionCable.server.broadcast 'componente_channel', componente: render_componente(componente)
#     end
#
#     private
#     def render_componente(componente)
#       ApplicationController.renderer.render(partial: "componentes/#{componente.controle_componente.descricao.downcase}", locals: { componente: componente })
#     end
# end
