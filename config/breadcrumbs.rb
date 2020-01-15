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

crumb :rooms_group do |group|
  link RoomGroup.model_name.human(count: 2), admin_group_rooms_group_path(group)
  parent :groups, group
end
crumb :room_group do |room_group|
  link room_group.to_s
  parent :rooms_group, room_group.group
end
crumb :room_group_new do |group|
  link t('views.actions.new')
  parent :rooms_group, group
end
crumb :room_group_edit do |room_group|
  link t('views.actions.do_edit'), edit_admin_room_group_path(room_group)
  parent :room_group, room_group
end

crumb :automacoes_group do |group|
  link AutomacaoGroup.model_name.human(count: 2), admin_group_automacoes_group_path(group)
  parent :groups, group
end
crumb :automacao_group do |automacao_group|
  link automacao_group.to_s
  parent :automacoes_group, automacao_group.group
end
crumb :automacao_group_new do |group|
  link t('views.actions.new')
  parent :automacoes_group, group
end
crumb :automacao_group_edit do |automacao_group|
  link t('views.actions.do_edit'), edit_admin_automacao_group_path(automacao_group)
  parent :automacao_group, automacao_group
end

crumb :automacoes_group_condicoes do |automacao_group|
  link UserAutomationCondition.model_name.human(count: 2), admin_automacao_group_automacoes_group_condicoes_path(automacao_group)
  parent :automacoes_group, automacao_group.group
end
crumb :automacao_group_condicao do |automacao_group_condicao|
  link automacao_group_condicao.to_s
  parent :automacoes_group_condicoes, automacao_group_condicao.automacao_group
end
crumb :automacao_group_condicao_new do |automacao_group|
  link t('views.actions.new')
  parent :automacoes_group_condicoes, automacao_group
end
crumb :automacao_group_condicao_edit do |automacao_group_condicao|
  link t('views.actions.do_edit'), edit_admin_automacao_group_condicao_path(automacao_group_condicao)
  parent :automacao_group_condicao, automacao_group_condicao
end

crumb :automacoes_group_acoes do |automacao_group|
  link AutomacaoGroupAcao.model_name.human(count: 2), admin_automacao_group_automacoes_group_acoes_path(automacao_group)
  parent :automacoes_group, automacao_group.group
end
crumb :automacao_group_acao do |automacao_group_acao|
  link automacao_group_acao.to_s
  parent :automacoes_group_acoes, automacao_group_acao.automacao_group
end
crumb :automacao_group_acao_new do |automacao_group|
  link t('views.actions.new')
  parent :automacoes_group_acoes, automacao_group
end
crumb :automacao_group_acao_edit do |automacao_group_acao|
  link t('views.actions.do_edit'), edit_admin_automacao_group_acao_path(automacao_group_acao)
  parent :automacao_group_acao, automacao_group_acao
end

crumb :devices_room do |room_group|
  link Device.model_name.human(count: 2), admin_room_group_devices_room_path(room_group)
  parent :rooms_group, room_group.group
end
crumb :device_room do |device_room|
  link device_room.to_s
  parent :devices_room, device_room.room_group
end
crumb :device_room_new do |room_group|
  link t('views.actions.new')
  parent :devices_room, room_group
end
crumb :device_room_edit do |device_room|
  link t('views.actions.do_edit'), edit_admin_device_room_path(device_room.room_group)
  parent :device_room, device_room
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