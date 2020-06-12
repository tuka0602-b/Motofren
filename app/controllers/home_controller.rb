class HomeController < ApplicationController
  def index
    @recruitments = Recruitment.includes([:user, :talk_room]).recent.all
  end
end
