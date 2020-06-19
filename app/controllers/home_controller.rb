class HomeController < ApplicationController
  def index
    @q = Recruitment.ransack(params[:q])
    @recruitments = @q.result.includes([:user, :area, :talk_room]).
      page(params[:page]).per(10).recent
  end
end
