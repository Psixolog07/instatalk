App.presence = App.cable.subscriptions.create "CurrentChannel",
  connected: ->
    console.log('CurrentChannel connected')

  disconnected: ->
    console.log('CurrentChannel disconnected')

  received: (data) ->
    console.log('CurrentChannel received')

    App.presence.online_users(data.users)

  online_users: (users) ->
    if (users.length > 0)
      all_users = users.map((user) -> "<span class='text-success ml-2'>#{user.nickname}</span>").join('')
      text =
        "<div>
          <h3 class='text-info'>Online users</h3>
            #{all_users}
        </div>"

      $('.online_users').html(text)
