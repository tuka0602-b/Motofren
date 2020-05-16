class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :destroy

  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end
end
