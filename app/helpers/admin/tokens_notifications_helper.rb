module Admin::TokensNotificationsHelper
  def notification_token_form_path(notification_token)
    if notification_token.new_record?
      admin_user_notification_tokens_path(notification_token.user)
    else
      admin_notification_token_path(notification_token)
    end
  end
end
