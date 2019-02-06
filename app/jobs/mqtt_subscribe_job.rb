class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*args)
    debugger
    puts args
    topicos = []

    ComponenteAmbiente.all.each do |_componente_ambiente|
    #  topicos.push(_componente_ambiente.topico).split(',')         unless topicos.include? _componente_ambiente.topico
      topicos.push(_componente_ambiente.topico_info1).split(',')   unless topicos.include? _componente_ambiente.topico_info1
      topicos.push(_componente_ambiente.topico_info2).split(',')   unless topicos.include? _componente_ambiente.topico_info2
      topicos.push(_componente_ambiente.topico_info3).split(',')   unless topicos.include? _componente_ambiente.topico_info3
      topicos.push(_componente_ambiente.topico_online).split(',')  unless topicos.include? _componente_ambiente.topico_online
      topicos.push(_componente_ambiente.topico_state).split(',')   unless topicos.include? _componente_ambiente.topico_state
      topicos.push(_componente_ambiente.topico_power).split(',')   unless topicos.include? _componente_ambiente.topico_power
    end

    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

    Thread.new do
      MQTT::Client.connect(conn_opts) do |_client|
        _client.subscribe(topicos)

        _client.get do |topic, message|
          if topic.include? 'INFO1' then
            componentes_ambientes = ComponenteAmbiente.where(topico_info1: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(info1: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'INFO2' then
            componentes_ambientes = ComponenteAmbiente.where(topico_info2: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(info2: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'INFO3' then
            componentes_ambientes = ComponenteAmbiente.where(topico_info3: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(info3: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'RESULT' then
            componentes_ambientes = ComponenteAmbiente.where(topico_result: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(result: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'STATE' then
            componentes_ambientes = ComponenteAmbiente.where(topico_state: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(state: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'POWER' then
            componentes_ambientes = ComponenteAmbiente.where(topico_power: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                power = false
                power = true if message.upcase.include? 'ON'
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(power: power)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
          if topic.include? 'LWT' then
            componentes_ambientes = ComponenteAmbiente.where(topico_online: topic)
            if componentes_ambientes.present?
              componentes_ambientes.each do |componente_ambiente|
                online = false
                online = true if message.upcase.include? 'ONLINE'
                puts componente_ambiente.descricao + ' - ' + message
                componente_ambiente.update!(onlline: online)
              end
            else
              Rails.logger.error('Erro no atualizar estado do componente ambiente')
            end
          end
        end
      end
    end
  end
end
