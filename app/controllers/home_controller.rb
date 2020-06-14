class HomeController < ApplicationController
  def index
    @q = Recruitment.ransack(params[:q])
    @recruitments = @q.result.includes([:user, :talk_room]).recent
  end
end
