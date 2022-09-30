App.presence = App.cable.subscriptions.create "PresenceChannel",
  connected: ->
    console.log("PresenceChannel connected")

  disconnected: ->
    console.log("PresenceChannel disconnected")

  received: (data) ->
    console.log("PresenceChannel received")

    if (data["status"] == "online")
      $("#online_users").append "<p id='#{data["user_id"]}'>#{data["nickname"]}</p>"
    
    if (data["status"] == "offline")
      $("##{data["user_id"]}").remove()
