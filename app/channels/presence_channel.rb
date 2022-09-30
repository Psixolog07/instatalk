class PresenceChannel < ApplicationCable::Channel
  def unsubscribed
    unless ActionCable.server.connections.map(&:current_user).include?(current_user)
      channel_action("offline")
      current_user.update(online: false)
    end
  end

  def subscribed
    stream_from "presence_channel"

    unless current_user.online
      channel_action("online")
      current_user.update(online: true)
    end
  end

  def channel_action(status)
    ActionCable.server.broadcast "presence_channel", user_id: current_user.id, status: status,
      nickname: current_user.nickname
  end
end
