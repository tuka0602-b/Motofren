module Notice
  def create_like_notification(current_user)
    temp = notifications.where(
      "visitor_id = ? and visited_id = ? and action = ?",
      current_user.id, user.id, "#{snake_case(self)}_like"
    )
    if temp.blank?
      notification = current_user.active_notifications.build(
        "#{snake_case(self)}_id": id,
        visited_id: user_id,
        action: "#{snake_case(self)}_like"
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_comment_notification(current_user, object)
    temp_ids =
      case self.class.name
      when "ImagePost"
        comments.select(:user_id).where.not(user_id: current_user.id).distinct
      when "Recruitment"
        talk_room.messages.select(:user_id).where.not(user_id: current_user.id).distinct
      end
    temp_ids.each do |temp_id|
      save_comment_notification(current_user, object, temp_id['user_id'])
    end
    save_comment_notification(current_user, object, user_id) if temp_ids.blank?
  end

  def save_comment_notification(current_user, object, visited_id)
    notification = current_user.active_notifications.build(
      "#{snake_case(self)}_id": id,
      "#{snake_case(object)}_id": object.id,
      visited_id: visited_id,
      action: "#{snake_case(self)}_comment"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def snake_case(object)
    object.class.name.underscore
  end
end
