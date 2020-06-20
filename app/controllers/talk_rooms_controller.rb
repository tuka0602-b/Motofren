class TalkRoomsController < ApplicationController
  def show
    @talk_room = TalkRoom.find(params[:id])
    @q = @talk_room.users.ransack(params[:q])
    @users = @q.result(distinct: true)
    @messages = Message.where(
      "user_id IN (?) AND talk_room_id = ?", @users.ids, @talk_room.id
    ).includes(:user).recent
    @message = current_user.messages.build
  end
end
