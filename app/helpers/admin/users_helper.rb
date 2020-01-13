module Admin::UsersHelper
  def admin_user_form_path(group, user)
    if user.new_record?
      admin_group_users_path(group)
    else
      admin_group_user_path(group, user)
    end
  end
end
