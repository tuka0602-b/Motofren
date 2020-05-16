class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback
  end

  def twitter
    callback
  end

  def google_oauth2
    callback
  end

  def failure
    redirect_to root_path
  end

  private

  def callback
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.save
      sign_in_and_redirect user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{user.provider}") if is_navigational_format?
    else
      set_flash_message(
        :alert, :failure,
        kind: "#{user.provider}", reason: "「#{user.email}」は既に別のアカウントで使用されています"
      )
      session["devise.user_attirbutes"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  # deviseのfind_messageをオーバーライド, google_oauth2認証時はフラッシュメッセージを変更している
  def find_message(kind, options = {})
    options[:scope] ||= translation_scope
    options[:default] = Array(options[:default]).unshift(kind.to_sym)
    options[:resource_name] = resource_name
    options[:kind] = "Google" if options[:kind] == "google_oauth2"
    options = devise_i18n_options(options)
    I18n.t("#{options[:resource_name]}.#{kind}", **options)
  end
end
