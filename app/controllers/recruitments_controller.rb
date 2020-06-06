class RecruitmentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @recruitment = current_user.recruitments.build
  end

  def create
    @recruitment = current_user.recruitments.build(recruitment_params)
    if @recruitment.save
      redirect_to @recruitment, notice: '募集を投稿しました'
    else
      render 'new'
    end
  end

  def edit
  end

  private

    def recruitment_params
      params.require(:recruitment).permit(:title, :content, :area_id, :date, :picture)
    end
end
