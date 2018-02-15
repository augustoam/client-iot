
App.componente_ambiente = App.cable.subscriptions.create "ComponenteAmbienteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.componente_ambiente.componente_ambiente_id isnt undefined
      if data.componente_ambiente.estado is "false"
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].removeAttribute("unchecked")
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].setAttribute("checked", "checked")
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].setAttribute("data-estado", "true")
      else
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].removeAttribute("checked")
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].setAttribute("unchecked", "unchecked")
        $("#{data.componente_ambiente.componente_ambiente_id}")[0].setAttribute("data-estado", "false")

  estado: (componente_ambiente) ->
    @perform 'estado', componente_ambiente: componente_ambiente

$ ->
  $(".botao-infra-vermelho").on "change", (event) ->
    App.componente_ambiente.estado {estado: event.target.getAttribute("data-estado"), componente_ambiente_id: '#'+event.target.id}
    event.target.value = ""
    event.preventDefault()
