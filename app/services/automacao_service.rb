class AutomacaoService

  CONDICAO_COMPONENTE        = 'device'
  CONDICAO_TIMER             = 'timer'
  CONDICAO_COMPLETE_MANUALLY = 'complete_manually'

  def initialize(room_device)
    @room_device = room_device
  end

  def call
    group_automations = GroupAutomation.joins(:group_automation_conditions).where(GroupAutomationCondition.table_name => { room_device: @room_device })

    group_automations.each do |group_automation|
      @condicao_valida  = false
      group_automation.group_automation_conditions.each do |group_automation_condition|

        if group_automation_condition.type_condition. == CONDICAO_COMPONENTE
          room_device = RoomDevice.find(group_automation_condition.room_device_id)
          if room_device.control.device.name.upcase == 'SYNCRELAY'
            if room_device.estado.to_s == group_automation_condition.device_propriedade.id_propriedade
              @condicao_valida = true
            else
              @condicao_valida = false
            end
          end

          if room_device.control.device.name.upcase == 'SYNCWEATHER'

            params = JSON.parse(room_device.valor)
            if group_automation_condition.device_propriedade.id_propriedade.upcase == 'ABOVE_TEMPERATURE'
              if params['temperatura'].to_f > group_automation_condition.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if group_automation_condition.device_propriedade.id_propriedade.upcase == 'BELOW_TEMPERATURE'
              if params['temperatura'].to_f < group_automation_condition.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if group_automation_condition.device_propriedade.id_propriedade.upcase == 'ABOVE_UMIDITY'
              if params['umidade'].to_f > group_automation_condition.value_set.to_f
                @condicao_valida = true
              else
                @condicao_valida = false
              end
            end
            if group_automation_condition.device_propriedade.id_propriedade.upcase == 'BELOW_UMIDITY'
              if params['umidade'].to_f < group_automation_condition.value_set.to_f
                @condicao_valida = true
              end
            end
          end

          if room_device.control.device.name.upcase == 'SYNCPRESENCE'
            if group_automation_condition.device_propriedade.id_propriedade == 'MOTION_DETECTED'
              if room_device.estado
                @condicao_valida = true
              end
            end
          end
        end
      end
      p ('automacao group: ').concat(group_automations.name).concat(' - ').concat(@condicao_valida)
    end
  end
end
