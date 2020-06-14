class TalkRoomsController < ApplicationController
  def show
    @talk_room = TalkRoom.includes(messages: [:user]).find(params[:id])
    @message = current_user.messages.build
  end
end
