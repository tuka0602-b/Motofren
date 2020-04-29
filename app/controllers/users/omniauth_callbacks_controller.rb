class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback
  end

  def twitter
    callback
  end

  def failure
    redirect_to root_path
  end

  private

  def callback
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.save
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      set_flash_message(
        :alert, :failure, 
        kind: "#{@user.provider}", reason: "「#{@user.email}」は既に別のアカウントで使用されています"
      )
      # 後でサインアップ画面にセッション情報を載せることを検討すべし
      # except("extra")でtwiiterからのレスポンスデータを制限し、CookieOverflowが発生しないようにしている
      session["devise.user_attirbutes"] = request.env["omniauth.auth"].except("extra") 
      redirect_to new_user_registration_url
    end
  end
end