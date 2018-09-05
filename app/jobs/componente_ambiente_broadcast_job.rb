class ComponenteAmbienteBroadcastJob < ApplicationJob
  queue_as :critical

  def perform(componente_ambiente)
    ActionCable.server.broadcast 'componente_ambiente_channel', componente_ambiente: render_componente_ambiente(componente_ambiente)
  end

  private

  def render_componente_ambiente(componente_ambiente)
    ApplicationController.renderer.render(partial: "componentes_ambiente/#{componente_ambiente.componente.layout_controle.descricao.downcase}",
                                          locals: { componente_ambiente: componente_ambiente })
  end
end
