module UsersHelper
  def user_form_path(group)
    if group.new_record?
      group_users_path(user.group)
    else
      group_user_path(group)
    end
  end

  def group_user(group, user)
    group.groups_users.find_by(user_id: user)
  end
end
