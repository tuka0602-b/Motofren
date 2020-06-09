class TalkRoomsController < ApplicationController
  def show
    @talk_room = TalkRoom.find(params[:id])
    @messages = @talk_room.messages
  end
end
