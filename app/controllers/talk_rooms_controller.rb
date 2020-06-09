class TalkRoomsController < ApplicationController
  def show
    @talk_room = TalkRoom.find(params[:id])
    @messages = @talk_room.messages
    @message = current_user.messages.build
  end
end
