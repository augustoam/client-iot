module UsersHelper
  def user_form_path(group)
    if group.new_record?
      group_users_path(user.group)
    else
      group_user_path(group)
    end
  end

  def user_group(group, user)
    group.user_groups.find_by(user_id: user)
  end
end
