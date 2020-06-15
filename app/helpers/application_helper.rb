module ApplicationHelper
  def current_user?(user)
    user == current_user
  end

  def full_title(page_title: '')
    base_title = "MotoFren"
    if page_title.blank?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
end
