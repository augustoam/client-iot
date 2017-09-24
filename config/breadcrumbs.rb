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

crumb :usuarios do |grupo|
  link grupo.to_s, admin_grupo_usuarios_path(grupo)
  parent :grupos
end
crumb :usuario do |grupo_usuario|
  link grupo_usuario.usuario.to_s
  parent :usuarios, grupo_usuario.grupo
end
crumb :usuario_edit do |grupo_usuario|
  link t('views.actions.edit'), edit_admin_grupo_usuario_path(grupo_usuario.grupo, grupo_usuario.usuario)
  parent :usuario, grupo_usuario
end
crumb :usuario_new do |grupo|
  link t('views.actions.new')
  parent :usuarios, grupo
end
