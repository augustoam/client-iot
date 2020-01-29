class SessionAuthenticationService
  class SessionAuthenticationError < StandardError
  end

  def initialize(params)
    @params = {
      email: params[:email].to_s.downcase,
      password: params[:password]
    }.freeze
  end

  def call
    authenticate!
    self
  end

  def success?
    @valid_session || false
  end

  def server_payload
    { json: JWTSessions::Session.new(payload: session_payload).login, status: :created }
  end

  def server_error
    raise 'Unauthorized'
  end

  private

  def session_payload
    {
      email: @user.email
    }
  end

  def authenticate!
    find_user_by_email!
    @valid_session = @user.valid_password?(@params[:password])
  end

  def find_user_by_email!
    @user = User.find_for_database_authentication(email: @params[:email])

    raise 'Unauthorized' unless @user.present?
  end
end
