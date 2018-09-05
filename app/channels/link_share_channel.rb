class LinkShareChannel < ApplicationCable::Channel
  def subscribed
    stream_from "LinkShareChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
