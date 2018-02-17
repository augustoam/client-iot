
App.componente_ambiente = App.cable.subscriptions.create "ComponenteAmbienteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    a = data.componente_ambiente.split(' ')[1].replace('"', '')
    d = a.replace(/.$/, '')
    console.log data
    $("##{d}").html ""
    $("##{d}").append data.componente_ambiente

  estado: (componente_ambiente) ->
    @perform 'estado', componente_ambiente: componente_ambiente
