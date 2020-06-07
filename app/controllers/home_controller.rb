class HomeController < ApplicationController
  def index
    @recruitments = Recruitment.recent.all
  end
end
