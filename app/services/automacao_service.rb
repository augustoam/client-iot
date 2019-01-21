class AutomacaoService

  CONDICAO_COMPONENTE        = 'componente'
  CONDICAO_TIMER             = 'timer'
  CONDICAO_COMPLETE_MANUALLY = 'complete_manually'

  def initialize(componente_ambiente)
    @componente_ambiente = componente_ambiente
  end

  def call
    automacoes_grupo = AutomacaoGrupo.joins(:automacoes_grupo_condicoes).where(AutomacaoGrupoCondicao.table_name => { componente_ambiente: @componente_ambiente })

    automacoes_grupo.each do |automacao_grupo|
      @condicao_valida  = false
      automacao_grupo.automacoes_grupo_condicoes.each do |automacao_grupo_condicao|

        if automacao_grupo_condicao.tipo_condicao. == CONDICAO_COMPONENTE
          componente_ambiente = ComponenteAmbiente.find(automacao_grupo_condicao.componente_ambiente_id)
          if componente_ambiente.controle.componente.descricao.upcase == 'SYNCRELAY'
            if componente_ambiente.estado.to_s == automacao_grupo_condicao.componente_propriedade.id_propriedade
              @condicao_valida = true
            else
              @condicao_valida = false
            end
          end

          if componente_ambiente.controle.componente.descricao.upcase == 'SYNCWEATHER'

            params = JSON.parse(componente_ambiente.valor)
            if automacao_grupo_condicao.componente_propriedade.id_propriedade.upcase == 'ABOVE_TEMPERATURE'
              if params['temperatura'].to_f > automacao_grupo_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade.upcase == 'BELOW_TEMPERATURE'
              if params['temperatura'].to_f < automacao_grupo_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade.upcase == 'ABOVE_UMIDITY'
              if params['umidade'].to_f > automacao_grupo_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_grupo_condicao.componente_propriedade.id_propriedade.upcase == 'BELOW_UMIDITY'
              if params['umidade'].to_f < automacao_grupo_condicao.value_set.to_f
                @condicao_valida = true
              end
            end
          end

          if componente_ambiente.controle.componente.descricao.upcase == 'SYNCPRESENCE'
            if automacao_grupo_condicao.componente_propriedade.id_propriedade == 'MOTION_DETECTED'
              if componente_ambiente.estado
                @condicao_valida = true
              end
            end
          end
        end
      end
      p ('automacao grupo: ').concat(automacoes_grupo.descricao).concat(' - ').concat(@condicao_valida)
    end
  end
end
