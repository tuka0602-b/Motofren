module UsersHelper
  # gravatarの使用は廃止、自由にプロフ画を変更できるように修正
  def gravatar_for(user, size: 110)
    if user.picture?
      image_tag(
        user.picture.url, alt: user.name,
                          class: "rounded-circle", width: "#{size}px", height: "auto"
      )
    else
      image_tag(
        "dafault.png", alt: user.name,
                       class: "rounded-circle", width: "#{size}px", height: "auto"
      )
    end
  end
end
