require 'sidekiq/scheduler'

AutomacaoGrupoCondicao.where(tipo_condicao: :timer).each do |automacao_grupo_condicao|
  if automacao_grupo_condicao.schedule_cron.present?
    Sidekiq.set_schedule("#{automacao_grupo_condicao.id}_publish_mqtt", { 'cron' => automacao_grupo_condicao.schedule_cron, 'class' => 'MqttPublishJob', 'args' => "#{automacao_grupo_condicao.automacao_grupo.id}" })
  end
end
