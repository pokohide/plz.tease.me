class SlideChannel < ApplicationCable::Channel
  def subscribed
    stream_from "slide_channel_#{params[:slide_id]}"
  end

  def unsubscribed; end

  def follow; end
end
