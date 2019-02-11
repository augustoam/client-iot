module Admin::TokensNotificacaoMobileHelper
  def token_notificacao_mobile_form_path(token_notificacao_mobile)
    if token_notificacao_mobile.new_record?
      admin_usuario_tokens_notificacao_mobile_path(token_notificacao_mobile.usuario)
    else
      admin_token_notificacao_mobile_path(token_notificacao_mobile)
    end
  end
end
