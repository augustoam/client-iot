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

crumb :ambientes do |grupo|
  link Ambiente.model_name.human(count: 2), admin_grupo_ambientes_path(grupo)
  parent :grupos, grupo
end
crumb :ambiente do |ambiente|
  link ambiente.to_s
  parent :ambientes, ambiente.grupo
end
crumb :ambiente_new do |grupo|
  link t('views.actions.new')
  parent :ambientes, grupo
end
crumb :ambiente_edit do |ambiente|
  link t('views.actions.do_edit'), edit_admin_ambiente_path(ambiente)
  parent :ambiente, ambiente
end

crumb :componentes do |ambiente|
  link Componente.model_name.human(count: 2), admin_ambiente_componentes_path(ambiente)
  parent :ambientes, ambiente.grupo
end
crumb :componente do |componente|
  link componente.to_s
  parent :componentes, componente.ambiente
end
crumb :componente_new do |ambiente|
  link t('views.actions.new')
  parent :componentes, ambiente
end
crumb :componente_edit do |componente|
  link t('views.actions.do_edit'), edit_admin_componente_path(componente.ambiente)
  parent :componente, componente
end

crumb :comandos_infra_vermelhos do |componente|
  link ComandoInfraVermelho.model_name.human(count: 2), admin_componente_comandos_infra_vermelhos_path(componente)
  parent :componentes, componente.ambiente
end
crumb :comando_infra_vermelho do |comando_infra_vermelho|
  link comando_infra_vermelho.to_s
  parent :comandos_infra_vermelhos, comando_infra_vermelho.componente
end
crumb :comando_infra_vermelho_new do |componente|
  link t('views.actions.new')
  parent :comandos_infra_vermelhos, componente
end
crumb :comando_infra_vermelho_edit do |comando_infra_vermelho|
  link t('views.actions.do_edit'), edit_admin_comando_infra_vermelho_path(comando_infra_vermelho)
  parent :comando_infra_vermelho, comando_infra_vermelho
end

crumb :controles_componentes do
  link ControleComponente.model_name.human(count: 2), admin_controles_componentes_path
  parent :root
end
crumb :controle_componente_edit do |controle_componente|
  link t('views.actions.do_edit'), edit_admin_controle_componente_path(controle_componente)
  parent :controles_componentes
end
crumb :controle_componente_new do |controle_componente|
  link t('views.actions.new')
  parent :controles_componentes
end
crumb :controle_componente do |controle_componente|
    link controle_componente.to_s, admin_controles_componentes_path(controle_componente)
    parent :controles_componentes
end

crumb :usuarios_all do
  link Usuario.model_name.human(count: 2), index_all_admin_usuarios_path
  parent :root
end
