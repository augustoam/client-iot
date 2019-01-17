module Admin::AutomacoesGrupoCondicoesHelper
  def admin_automacao_grupo_condicao_form_path(automacao_grupo, automacao_grupo_condicao)
    if automacao_grupo_condicao.new_record?
      admin_automacao_grupo_automacoes_grupo_condicoes_path(automacao_grupo)
    else
      admin_automacao_grupo_condicao_path(automacao_grupo_condicao)
    end
  end

  def tipo_condicao_keys
     AutomacaoGrupoCondicao.tipo_condicaos.keys.collect{|t| [t_enum(AutomacaoGrupoCondicao, "tipo_condicao", t), t] }
  end
end
