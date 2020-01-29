class SendConfirmationInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user)
    Devise::Mailer.confirmation_instructions(user, user.confirmation_token).deliver
  end
end
