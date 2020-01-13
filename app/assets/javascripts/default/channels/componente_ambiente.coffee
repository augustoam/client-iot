
App.device_room = App.cable.subscriptions.create "DeviceRoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    a = data.device_room.split(' ')[1].replace('"', '')
    d = a.replace(/.$/, '')
    console.log data
    $("##{d}").html ""
    $("##{d}").append data.device_room

  estado: (device_room) ->
    @perform 'estado', device_room: device_room
