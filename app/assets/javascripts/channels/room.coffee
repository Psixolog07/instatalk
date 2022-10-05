jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')

  if messages.length > 0
    if App.room
      App.cable.subscriptions.remove(App.room)
    createRoomChannel messages.data('room-id')

  $(document).on 'keypress', '#message_body', (event) ->
    message = event.target.value
    if event.keyCode is 13 && message != ''
      App.room.speak(message)
      event.target.value = ""
      event.preventDefault()

createRoomChannel = (roomId) ->
  App.room = App.cable.subscriptions.create {channel: "RoomChannel", roomId: roomId},
    connected: ->
      console.log('Connected to RoomChannel')

    disconnected: ->
      console.log('Disconnected from RoomChannel')

    received: (data) ->
      console.log('Received message: ' + data['message'])
      $('#messages').append data['message']

    speak: (message) ->
      @perform 'speak', message: message
