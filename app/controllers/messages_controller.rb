class MessagesController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @talk_room = TalkRoom.find(params[:talk_room_id])
    @message = current_user.messages.build(message_params)
    @message.talk_room_id = @talk_room.id
    @message.save
    @talk_room.recruitment.create_comment_notification(current_user, @message)
    @messages = @talk_room.messages.includes(:user).recent
  end

  def destroy
    @message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    redirect_to root_url if @message.nil?
  end
end
