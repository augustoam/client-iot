class ConvidarUsuarioByEmailJob < ApplicationJob

  queue_as :default

  def perform(usuario)
    debugger
    Devise::Mailer.confirmation_instructions(usuario, usuario.confirmation_token).deliver
  end

end
