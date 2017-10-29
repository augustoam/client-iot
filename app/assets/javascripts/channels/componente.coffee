App.componente = App.cable.subscriptions.create "ComponenteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    #alert(data['componente'])
    window.location.reload();
    #$('#componente').append data['componente']

  estado: (componente) ->
    @perform 'estado', componente: componente

$ ->
  $(".botao-infra-vermelho").on "change", (event) ->
    console.log(event)
    App.componente.estado event.target.value
    event.target.value = ""
    event.preventDefault()
