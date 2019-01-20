class AutomacaoService

  CONDICAO_COMPONENTE        = 'componente'
  CONDICAO_TIMER             = 'timer'
  CONDICAO_COMPLETE_MANUALLY = 'complete_manually'

  def initialize(componente_ambiente)
    @componente_ambiente = componente_ambiente
  end

  def call
    debugger
    automacoes_grupo = AutomacaoGrupo.joins(:automacoes_grupo_condicoes).where(AutomacaoGrupoCondicao.table_name => { componente_ambiente: @componente_ambiente })

    automacoes_grupo.each do |automacao_grupo|
      debugger
      automacao_grupo.automacoes_grupo_condicoes.each do |automacao_grupo_condicao|
        debugger
        if automacao_grupo_condicao.tipo_condicao == CONDICAO_COMPONENTE
          if @componente_ambiente.controle.componente.descricao == 'SYNCRELAY'
            if @componente.estado == automacao_grupo_condicao.componente_propriedade.id_propriedade
              @condicao_valida = true
            end
          end
          if @componente_ambiente.controle.componente.descricao == 'SYNCWEATHER'
            params = JSON.parse(@componente.valor)
            if automacao_grupo_condicao.componente_propriedade.id_propriedade == 'ABOVE_TEMPERATURE'
              if params['temperatura'].to_f > automacao_grupo_condicao.value_set
                @condicao_valida = true
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade == 'BELOW_TEMPERATURE'
              if params['temperatura'].to_f < automacao_grupo_condicao.value_set
                @condicao_valida = true
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade == 'ABOVE_UMIDITY'
              if params['umidade'].to_f > automacao_grupo_condicao.value_set
                @condicao_valida = true
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade == 'BELOW_UMIDITY'
              if params['umidade'].to_f < automacao_grupo_condicao.value_set
                @condicao_valida = true
              end
            end
          end
        end
      end
    end
  end
end
