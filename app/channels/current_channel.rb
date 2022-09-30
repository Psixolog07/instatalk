class CurrentChannel < ApplicationCable::Channel
  def unsubscribed
    current_user.update_attribute(:online, false)
  end

  def subscribed
    stream_from 'current_channel'

    current_user.update_attribute(:online, true)
    ActionCable.server.broadcast 'current_channel', users: User.online.list
  end
end
