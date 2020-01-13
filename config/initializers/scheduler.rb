require 'sidekiq/scheduler'

#UserAutomationCondition.where(tipo_condicao: :timer).each do |automacao_group_condicao|
 # if automacao_group_condicao.schedule_cron.present?
#    Sidekiq.set_schedule("#{automacao_group_condicao.id}_publish_mqtt", { 'cron' => automacao_group_condicao.schedule_cron, 'class' => 'MqttPublishJob', 'args' => "#{automacao_group_condicao.automacao_group.id}" })
#  end
#end
