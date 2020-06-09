class MessagesController < ApplicationController
  def create
    @talk_room = TalkRoom.find(params[:talk_room_id])
    @message = current_user.messages.build(message_params)
    @message.talk_room_id = @talk_room.id
    if @message.save
      redirect_to @talk_room
    else
      redirect_to root_path
    end
  end

  def destroy
    @talk_room = TalkRoom.find(params[:talk_room_id])
    @message = Message.find(params[:id]).destroy
    flash[:notice] = "メッセージを削除しました"
    redirect_to @talk_room
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
