module UsersHelper
  def gravatar_for(user, size: 100)
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
