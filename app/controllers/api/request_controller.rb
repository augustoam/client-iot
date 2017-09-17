class Api::RequestController < ActionController::API
  #include ActionController::HttpAuthentication::Basic::ControllerMethods
  include MqttBroker
  #http_basic_authenticate_with name: "augusto.albertoni@gmail.com", password: "amendoim"
  #before_action :user_name_and_password
  def google_api_request
    debugger
    device   = params[:result][:parameters][:device]
    location = params[:result][:parameters][:location]
    state    = params[:result][:parameters][:state]
    user     = params[:result][:parameters][:user]
    topic   = 'augusto.albertoni@gmail.com/' + location + '/' + device
    publish_mqtt(topic, state)
    render json: 'okey'
  end
end
