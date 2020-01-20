require 'sidekiq/scheduler'

#GroupAutomationCondition.where(type_condition: :timer).each do |group_automation_condition|
 # if group_automation_condition.schedule_cron.present?
#    Sidekiq.set_schedule("#{group_automation_condition.id}_publish_mqtt", { 'cron' => group_automation_condition.schedule_cron, 'class' => 'MqttPublishJob', 'args' => "#{group_automation_condition.group_automation.id}" })
#  end
#end
