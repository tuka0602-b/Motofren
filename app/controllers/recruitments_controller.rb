class RecruitmentsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recruitment = current_user.recruitments.build
  end

  def create
    @recruitment = current_user.recruitments.build(recruitment_params)
    if @recruitment.save
      redirect_to root_url, notice: '募集を投稿しました'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recruitment.update(recruitment_params)
      redirect_to root_url, notice: '募集を編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @recruitment.destroy
    flash[:notice] = "募集を削除しました"
    redirect_to root_url
  end

  def liked_users
    @recruitment = Recruitment.find(params[:id])
    @user = @recruitment.user
    @users = @recruitment.liked_users.page(params[:page]).per(20)
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :content, :area_id, :date, :picture)
  end

  def correct_user
    @recruitment = current_user.recruitments.find_by(id: params[:id])
    redirect_to root_url if @recruitment.nil?
  end
end
