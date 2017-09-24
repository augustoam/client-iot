crumb :root do
  link "Home", root_path
end

crumb :grupos do
  link Grupo.model_name.human(count: 2), admin_grupos_path
  parent :root
end
crumb :grupo do |grupo|
  link grupo.to_s, admin_grupo_path(grupo)
  parent :grupos
end
crumb :grupo_edit do |grupo|
  link t('views.actions.do_edit'), edit_admin_grupo_path(grupo)
  parent :grupo, grupo
end
crumb :grupo_new do
  link t('views.actions.new')
  parent :grupos
end
