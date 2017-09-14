class Api::RequestController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include MqttBroker  
  http_basic_authenticate_with name: "augusto.albertoni@gmail.com", password: "amendoim"
  
  def google_api_request
    device   = params[:result][:parameters][:device]
    location = params[:result][:parameters][:location]
    state    = params[:result][:parameters][:state]
    user     = params[:result][:parameters][:user]
    topic   = 'augusto.albertoni@gmail.com/' + location + '/' + device
    publish_mqtt(topic, state)
  end
end