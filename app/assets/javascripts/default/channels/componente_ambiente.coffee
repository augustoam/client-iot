
App.room_device = App.cable.subscriptions.create "RoomDeviceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    a = data.room_device.split(' ')[1].replace('"', '')
    d = a.replace(/.$/, '')
    console.log data
    $("##{d}").html ""
    $("##{d}").append data.room_device

  estado: (room_device) ->
    @perform 'estado', room_device: room_device
