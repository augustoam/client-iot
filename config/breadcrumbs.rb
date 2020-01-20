crumb :root do
  link 'Home', root_path
end

crumb :groups do
  link Group.model_name.human(count: 2), admin_groups_path
  parent :root
end
crumb :group do |group|
  link group.to_s, admin_group_path(group)
  parent :groups
end
crumb :group_edit do |group|
  link t('views.actions.do_edit'), edit_admin_group_path(group)
  parent :group, group
end
crumb :group_new do
  link t('views.actions.new')
  parent :groups
end

crumb :users do |group|
  link group.to_s, admin_group_users_path(group)
  parent :groups
end
crumb :user do |group_user|
  link group_user.user.to_s
  parent :users, group_user.group
end
crumb :user_edit do |group_user|
  link t('views.actions.edit'), edit_admin_group_user_path(group_user.group, group_user.user)
  parent :user, group_user
end
crumb :user_new do |group|
  link t('views.actions.new')
  parent :users, group
end

crumb :rooms do
  link Room.model_name.human(count: 2), admin_rooms_path
  parent :root
end
crumb :room do |room|
  link room.to_s, admin_room_path(room)
  parent :rooms
end
crumb :room_edit do |room|
  link t('views.actions.do_edit'), edit_admin_room_path(room)
  parent :room, room
end
crumb :room_new do
  link t('views.actions.new')
  parent :rooms
end

crumb :group_rooms do |group|
  link GroupRoom.model_name.human(count: 2), admin_group_group_rooms_path(group)
  parent :groups, group
end
crumb :group_room do |group_room|
  link group_room.to_s
  parent :group_rooms, group_room.group
end
crumb :group_room_new do |group|
  link t('views.actions.new')
  parent :group_rooms, group
end
crumb :group_room_edit do |group_room|
  link t('views.actions.do_edit'), edit_admin_group_room_path(group_room)
  parent :group_room, group_room
end

crumb :group_automations do |group|
  link GroupAutomation.model_name.human(count: 2), admin_group_group_automations_path(group)
  parent :groups, group
end
crumb :group_automation do |group_automation|
  link group_automation.to_s
  parent :group_automations, group_automation.group
end
crumb :group_automation_new do |group|
  link t('views.actions.new')
  parent :group_automations, group
end
crumb :group_automation_edit do |group_automation|
  link t('views.actions.do_edit'), edit_admin_group_automation_path(group_automation)
  parent :group_automation, group_automation
end

crumb :group_automation_conditions do |group_automation|
  link GroupAutomationCondition.model_name.human(count: 2), admin_group_automation_group_automation_conditions_path(group_automation)
  parent :group_automations, group_automation.group
end
crumb :group_automation_condition do |group_automation_condition|
  link group_automation_condition.to_s
  parent :group_automation_conditions, group_automation_condition.group_automation
end
crumb :group_automation_condition_new do |group_automation|
  link t('views.actions.new')
  parent :group_automation_conditions, group_automation
end
crumb :group_automation_condition_edit do |group_automation_condition|
  link t('views.actions.do_edit'), edit_admin_group_automation_condition_path(group_automation_condition)
  parent :group_automation_condition, group_automation_condition
end

crumb :group_automation_actions do |group_automation|
  link GroupAutomationAction.model_name.human(count: 2), admin_group_automation_group_automation_actions_path(group_automation)
  parent :group_automations, group_automation.group
end
crumb :group_automation_action do |group_automation_action|
  link group_automation_action.to_s
  parent :group_automation_actions, group_automation_action.group_automation
end
crumb :group_automation_action_new do |group_automation|
  link t('views.actions.new')
  parent :group_automation_actions, group_automation
end
crumb :group_automation_action_edit do |group_automation_action|
  link t('views.actions.do_edit'), edit_admin_group_automation_action_path(group_automation_action)
  parent :group_automation_action, group_automation_action
end

crumb :room_devices do |group_room|
  link Device.model_name.human(count: 2), admin_group_room_room_devices_path(group_room)
  parent :group_rooms, group_room.group
end
crumb :room_device do |room_device|
  link room_device.to_s
  parent :room_devices, room_device.group_room
end
crumb :room_device_new do |group_room|
  link t('views.actions.new')
  parent :room_devices, group_room
end
crumb :room_device_edit do |room_device|
  link t('views.actions.do_edit'), edit_admin_room_device_path(room_device.group_room)
  parent :room_device, room_device
end

crumb :control_commands do |control|
  link ControlCommand.model_name.human(count: 2), admin_control_control_commands_path(control)
  parent :controls, control.name
end
crumb :control_command do |control_command|
  link control_command.to_s
  parent :control_commands, control_command.control
end
crumb :control_command_new do |control|
  link t('views.actions.new')
  parent :control_commands, control
end
crumb :control_command_edit do |control_command|
  link t('views.actions.do_edit'), edit_admin_control_command_path(control_command)
  parent :control_command, control_command
end

crumb :devices do
  link Device.model_name.human(count: 2), admin_devices_path
  parent :root
end
crumb :device_edit do |device|
  link t('views.actions.do_edit'), edit_admin_device_path(device)
  parent :device, device
end
crumb :device_new do |_device|
  link t('views.actions.new')
  parent :devices
end
crumb :device do |device|
  link device.to_s
  parent :devices
end

crumb :devices_propriedades do |device|
  link device.name.concat(' Propriedades'), admin_device_devices_propriedades_path(device)
  parent :devices, device
end
crumb :device_propriedade do |device_propriedade|
  link device_propriedade.to_s
  parent :devices_propriedades, device_propriedade.device
end
crumb :device_propriedade_new do |device|
  link t('views.actions.new')
  parent :devices_propriedades, device
end
crumb :device_propriedade_edit do |device_propriedade|
  link t('views.actions.do_edit'), edit_admin_device_propriedade_path(device_propriedade)
  parent :device_propriedade, device_propriedade
end

crumb :control_layouts do
  link ControlLayout.model_name.human(count: 2), admin_control_layouts_path
  parent :root
end
crumb :control_layout_edit do |control_layout|
  link t('views.actions.do_edit'), edit_admin_control_layout_path(control_layout)
  parent :control_layout, control_layout
end
crumb :control_layout_new do |_control_layout|
  link t('views.actions.new')
  parent :control_layouts
end
crumb :control_layout do |control_layout|
  link control_layout.to_s
  parent :control_layouts
end

crumb :controls do
  link Control.model_name.human(count: 2), admin_controls_path
  parent :root
end
crumb :control_edit do |control|
  link t('views.actions.do_edit'), edit_admin_control_path(control)
  parent :control, control
end
crumb :control_new do |_control|
  link t('views.actions.new')
  parent :controls
end
crumb :control do |control|
  link control.to_s
  parent :controls
end

crumb :users_all do
  link User.model_name.human(count: 2), index_all_admin_users_path
  parent :root
end

crumb :notification_tokens do |user|
  link user.to_s, admin_user_notification_tokens_path(user)
  parent :users_all
end
crumb :notification_token do |notification_token|
  link notification_token.to_s
  parent :notification_tokens, notification_token.user
end
crumb :notification_token_edit do |notification_token|
  link t('views.actions.edit'), edit_admin_notification_token_path(notification_token)
  parent :notification_token, notification_token
end
crumb :notification_token_new do |notification_token|
  link t('views.actions.new')
  parent :notification_tokens, notification_token.user
end


crumb :manufacturers do
  link Manufacturer.model_name.human(count: 2), admin_manufacturers_path
  parent :root
end
crumb :manufacturer do |manufacturer|
  link manufacturer.to_s, admin_manufacturer_path(manufacturer)
  parent :manufacturers
end
crumb :manufacturer_edit do |manufacturer|
  link t('views.actions.do_edit'), edit_admin_manufacturer_path(manufacturer)
  parent :manufacturer, manufacturer
end
crumb :manufacturer_new do
  link t('views.actions.new')
  parent :manufacturers
end