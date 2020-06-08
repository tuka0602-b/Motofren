class RecruitmentLikesController < ApplicationController
  def create
    @recruitment = Recruitment.find(params[:recruitment_id])
    current_user.recruitment_like(@recruitment)
  end

  def destroy
    @recruitment = RecruitmentLike.find(params[:id]).recruitment
    current_user.recruitment_unlike(@recruitment)
  end
end
