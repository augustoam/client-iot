class Api::RequestController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include MqttBroker  
  before_action :authenticate
  
  def google_api_request
    device   = params[:result][:parameters][:device]
    location = params[:result][:parameters][:location]
    state    = params[:result][:parameters][:state]
    user     = params[:result][:parameters][:user]
    topic   = 'augusto.albertoni@gmail.com/' + location + '/' + device
    publish_mqtt(topic, state)
  end

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        # Compare the tokens in a time-constant manner, to mitigate
        # timing attacks.
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(token),
          ::Digest::SHA256.hexdigest('90bdd5fee76b44188a17f46de744756f')
        )
      end
    end
end