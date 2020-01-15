# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'user', 'users'
  inflect.irregular 'notification_token', 'notification_tokens'
  inflect.irregular 'group', 'groups'
  inflect.irregular 'user_group', 'user_groups'
  inflect.irregular 'room', 'rooms'
  inflect.irregular 'group_room', 'group_rooms'
  inflect.irregular 'device', 'devices'
  inflect.irregular 'room_device', 'room_devices'
  inflect.irregular 'admin', 'admins'
  inflect.irregular 'control_layout', 'control_layouts'
  inflect.irregular 'control', 'controls'
  inflect.irregular 'control_command', 'control_commands'
  inflect.irregular 'manufacturer', 'manufacturers'
  inflect.irregular 'user_automation', 'users_automations'
  inflect.irregular 'user_automation_condition', 'user_automation_conditions'
  inflect.irregular 'user_automation_action', 'user_automation_actions'
end
