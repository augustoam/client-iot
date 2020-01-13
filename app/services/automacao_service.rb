class AutomacaoService

  CONDICAO_COMPONENTE        = 'device'
  CONDICAO_TIMER             = 'timer'
  CONDICAO_COMPLETE_MANUALLY = 'complete_manually'

  def initialize(device_room)
    @device_room = device_room
  end

  def call
    automacoes_group = AutomacaoGroup.joins(:automacoes_group_condicoes).where(UserAutomationCondition.table_name => { device_room: @device_room })

    automacoes_group.each do |automacao_group|
      @condicao_valida  = false
      automacao_group.automacoes_group_condicoes.each do |automacao_group_condicao|

        if automacao_group_condicao.tipo_condicao. == CONDICAO_COMPONENTE
          device_room = DeviceRoom.find(automacao_group_condicao.device_room_id)
          if device_room.control.device.descricao.upcase == 'SYNCRELAY'
            if device_room.estado.to_s == automacao_group_condicao.device_propriedade.id_propriedade
              @condicao_valida = true
            else
              @condicao_valida = false
            end
          end

          if device_room.control.device.descricao.upcase == 'SYNCWEATHER'

            params = JSON.parse(device_room.valor)
            if automacao_group_condicao.device_propriedade.id_propriedade.upcase == 'ABOVE_TEMPERATURE'
              if params['temperatura'].to_f > automacao_group_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_group_condicao.device_propriedade.id_propriedade.upcase == 'BELOW_TEMPERATURE'
              if params['temperatura'].to_f < automacao_group_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_group_condicao.device_propriedade.id_propriedade.upcase == 'ABOVE_UMIDITY'
              if params['umidade'].to_f > automacao_group_condicao.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if automacao_group_condicao.device_propriedade.id_propriedade.upcase == 'BELOW_UMIDITY'
              if params['umidade'].to_f < automacao_group_condicao.value_set.to_f
                @condicao_valida = true
              end
            end
          end

          if device_room.control.device.descricao.upcase == 'SYNCPRESENCE'
            if automacao_group_condicao.device_propriedade.id_propriedade == 'MOTION_DETECTED'
              if device_room.estado
                @condicao_valida = true
              end
            end
          end
        end
      end
      p ('automacao group: ').concat(automacoes_group.descricao).concat(' - ').concat(@condicao_valida)
    end
  end
end
