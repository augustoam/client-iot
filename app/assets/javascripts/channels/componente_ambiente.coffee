App.componente_ambiente = App.cable.subscriptions.create "ComponenteAmbienteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#componente_ambiente").html  "";
    $("#componente_ambiente").append data['componente_ambiente']

  estado: (componente_ambiente) ->
    @perform 'estado', componente_ambiente: componente_ambiente

$ ->
  $(".botao-infra-vermelho").on "change", (event) ->
    console.log(event)
    App.componente_ambiente.estado event.target.value
    event.target.value = ""
    event.preventDefault()
