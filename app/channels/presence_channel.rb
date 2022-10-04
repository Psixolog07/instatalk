class PresenceChannel < ApplicationCable::Channel
  def unsubscribed
    current_user.online = current_user.online - 1
    current_user.save
    channel_action("offline") if current_user.online == 0
  end

  def subscribed
    stream_from "presence_channel"
    channel_action("online") if current_user.online == 0
    current_user.online = current_user.online + 1
    current_user.save
  end

  def channel_action(status)
    ActionCable.server.broadcast "presence_channel", user_id: current_user.id, status: status,
      nickname: current_user.nickname
  end
end
