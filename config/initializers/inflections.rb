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
  inflect.irregular 'usuario', 'usuarios'
  inflect.irregular 'token_notificacao_mobile', 'tokens_notificacao_mobile'
  inflect.irregular 'grupo', 'grupos'
  inflect.irregular 'grupo_usuario', 'grupos_usuarios'
  inflect.irregular 'ambiente', 'ambientes'
  inflect.irregular 'ambiente_grupo', 'ambientes_grupo'
  inflect.irregular 'componente', 'componentes'
  inflect.irregular 'componente_ambiente', 'componentes_ambiente'
  inflect.irregular 'admin', 'admins'
  inflect.irregular 'layout_controle', 'layout_controles'
  inflect.irregular 'controle', 'controles'
  inflect.irregular 'comando_infra_vermelho', 'comandos_infra_vermelhos'
  inflect.irregular 'fabricante', 'fabricantes'
  inflect.irregular 'automacao_grupo', 'automacoes_grupo'
end
