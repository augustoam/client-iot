crumb :root do
  link 'Home', root_path
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

crumb :ambientes do
  link Ambiente.model_name.human(count: 2), admin_ambientes_path
  parent :root
end
crumb :ambiente do |ambiente|
  link ambiente.to_s, admin_ambiente_path(ambiente)
  parent :ambientes
end
crumb :ambiente_edit do |ambiente|
  link t('views.actions.do_edit'), edit_admin_ambiente_path(ambiente)
  parent :ambiente, ambiente
end
crumb :ambiente_new do
  link t('views.actions.new')
  parent :ambientes
end

crumb :ambientes_grupo do |grupo|
  link AmbienteGrupo.model_name.human(count: 2), admin_grupo_ambientes_grupo_path(grupo)
  parent :grupos, grupo
end
crumb :ambiente_grupo do |ambiente_grupo|
  link ambiente_grupo.to_s
  parent :ambientes_grupo, ambiente_grupo.grupo
end
crumb :ambiente_grupo_new do |grupo|
  link t('views.actions.new')
  parent :ambientes_grupo, grupo
end
crumb :ambiente_grupo_edit do |ambiente_grupo|
  link t('views.actions.do_edit'), edit_admin_ambiente_grupo_path(ambiente_grupo)
  parent :ambiente_grupo, ambiente_grupo
end

crumb :automacoes_grupo do |grupo|
  link AutomacaoGrupo.model_name.human(count: 2), admin_grupo_automacoes_grupo_path(grupo)
  parent :grupos, grupo
end
crumb :automacao_grupo do |automacao_grupo|
  link automacao_grupo.to_s
  parent :automacoes_grupo, automacao_grupo.grupo
end
crumb :automacao_grupo_new do |grupo|
  link t('views.actions.new')
  parent :automacoes_grupo, grupo
end
crumb :automacao_grupo_edit do |automacao_grupo|
  link t('views.actions.do_edit'), edit_admin_automacao_grupo_path(automacao_grupo)
  parent :automacao_grupo, automacao_grupo
end

crumb :automacoes_grupo_condicoes do |automacao_grupo|
  link AutomacaoGrupoCondicao.model_name.human(count: 2), admin_automacao_grupo_automacoes_grupo_condicoes_path(automacao_grupo)
  parent :automacoes_grupo, automacao_grupo.grupo
end
crumb :automacao_grupo_condicao do |automacao_grupo_condicao|
  link automacao_grupo_condicao.to_s
  parent :automacoes_grupo_condicoes, automacao_grupo_condicao.automacao_grupo
end
crumb :automacao_grupo_condicao_new do |automacao_grupo|
  link t('views.actions.new')
  parent :automacoes_grupo_condicoes, automacao_grupo
end
crumb :automacao_grupo_condicao_edit do |automacao_grupo_condicao|
  link t('views.actions.do_edit'), edit_admin_automacao_grupo_condicao_path(automacao_grupo_condicao)
  parent :automacao_grupo_condicao, automacao_grupo_condicao
end

crumb :automacoes_grupo_acoes do |automacao_grupo|
  link AutomacaoGrupoAcao.model_name.human(count: 2), admin_automacao_grupo_automacoes_grupo_acoes_path(automacao_grupo)
  parent :automacoes_grupo, automacao_grupo.grupo
end
crumb :automacao_grupo_acao do |automacao_grupo_acao|
  link automacao_grupo_acao.to_s
  parent :automacoes_grupo_acoes, automacao_grupo_acao.automacao_grupo
end
crumb :automacao_grupo_acao_new do |automacao_grupo|
  link t('views.actions.new')
  parent :automacoes_grupo_acoes, automacao_grupo
end
crumb :automacao_grupo_acao_edit do |automacao_grupo_acao|
  link t('views.actions.do_edit'), edit_admin_automacao_grupo_acao_path(automacao_grupo_acao)
  parent :automacao_grupo_acao, automacao_grupo_acao
end

crumb :componentes_ambiente do |ambiente_grupo|
  link Componente.model_name.human(count: 2), admin_ambiente_grupo_componentes_ambiente_path(ambiente_grupo)
  parent :ambientes_grupo, ambiente_grupo.grupo
end
crumb :componente_ambiente do |componente_ambiente|
  link componente_ambiente.to_s
  parent :componentes_ambiente, componente_ambiente.ambiente_grupo
end
crumb :componente_ambiente_new do |ambiente_grupo|
  link t('views.actions.new')
  parent :componentes_ambiente, ambiente_grupo
end
crumb :componente_ambiente_edit do |componente_ambiente|
  link t('views.actions.do_edit'), edit_admin_componente_ambiente_path(componente_ambiente.ambiente_grupo)
  parent :componente_ambiente, componente_ambiente
end

crumb :controle_comandos do |controle|
  link ControleComando.model_name.human(count: 2), admin_controle_controle_comandos_path(controle)
  parent :controles, controle.descricao
end
crumb :controle_comando do |controle_comando|
  link controle_comando.to_s
  parent :controle_comandos, controle_comando.controle
end
crumb :controle_comando_new do |controle|
  link t('views.actions.new')
  parent :controle_comandos, controle
end
crumb :controle_comando_edit do |controle_comando|
  link t('views.actions.do_edit'), edit_admin_controle_comando_path(controle_comando)
  parent :controle_comando, controle_comando
end

crumb :componentes do
  link Componente.model_name.human(count: 2), admin_componentes_path
  parent :root
end
crumb :componente_edit do |componente|
  link t('views.actions.do_edit'), edit_admin_componente_path(componente)
  parent :componente, componente
end
crumb :componente_new do |_componente|
  link t('views.actions.new')
  parent :componentes
end
crumb :componente do |componente|
  link componente.to_s
  parent :componentes
end

crumb :componentes_propriedades do |componente|
  link componente.descricao.concat(' Propriedades'), admin_componente_componentes_propriedades_path(componente)
  parent :componentes, componente
end
crumb :componente_propriedade do |componente_propriedade|
  link componente_propriedade.to_s
  parent :componentes_propriedades, componente_propriedade.componente
end
crumb :componente_propriedade_new do |componente|
  link t('views.actions.new')
  parent :componentes_propriedades, componente
end
crumb :componente_propriedade_edit do |componente_propriedade|
  link t('views.actions.do_edit'), edit_admin_componente_propriedade_path(componente_propriedade)
  parent :componente_propriedade, componente_propriedade
end

crumb :layout_controles do
  link LayoutControle.model_name.human(count: 2), admin_layout_controles_path
  parent :root
end
crumb :layout_controle_edit do |layout_controle|
  link t('views.actions.do_edit'), edit_admin_layout_controle_path(layout_controle)
  parent :layout_controle, layout_controle
end
crumb :layout_controle_new do |_layout_controle|
  link t('views.actions.new')
  parent :layout_controles
end
crumb :layout_controle do |layout_controle|
  link layout_controle.to_s
  parent :layout_controles
end

crumb :controles do
  link Controle.model_name.human(count: 2), admin_controles_path
  parent :root
end
crumb :controle_edit do |controle|
  link t('views.actions.do_edit'), edit_admin_controle_path(controle)
  parent :controle, controle
end
crumb :controle_new do |_controle|
  link t('views.actions.new')
  parent :controles
end
crumb :controle do |controle|
  link controle.to_s
  parent :controles
end

crumb :usuarios_all do
  link Usuario.model_name.human(count: 2), index_all_admin_usuarios_path
  parent :root
end

crumb :tokens_notificacao_mobile do |usuario|
  link usuario.to_s, admin_usuario_tokens_notificacao_mobile_path(usuario)
  parent :usuarios_all
end
crumb :token_notificacao_mobile do |token_notificacao_mobile|
  link token_notificacao_mobile.to_s
  parent :tokens_notificacao_mobile, token_notificacao_mobile.usuario
end
crumb :token_notificacao_mobile_edit do |token_notificacao_mobile|
  link t('views.actions.edit'), edit_admin_token_notificacao_mobile_path(token_notificacao_mobile)
  parent :token_notificacao_mobile, token_notificacao_mobile
end
crumb :token_notificacao_mobile_new do |token_notificacao_mobile|
  link t('views.actions.new')
  parent :tokens_notificacao_mobile, token_notificacao_mobile.usuario
end
