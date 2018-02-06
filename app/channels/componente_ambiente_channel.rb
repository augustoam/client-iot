class ComponenteAmbienteChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'componente_ambiente_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def estado(data)
    ActionCable.server.broadcast 'componente_ambiente_channel', componente_ambiente: data['componente_ambiente']
  end
end
