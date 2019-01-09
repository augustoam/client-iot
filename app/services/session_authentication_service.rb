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
    autentica_usuario!
    self
  end

  def success?
    @sessao_valida || false
  end

  def server_payload
    { json: JWTSessions::Session.new(payload: session_payload).login, status: :created }
  end

  def server_error
    { json: { error: 'Senha inválida' }, status: :unauthorized }
  end

  private

  def session_payload
    {
      email: @user.email
    }
  end

  def autentica_usuario!
    find_usuario_by_email!
    @sessao_valida = @user.valid_password?(@params[:password])
  end

  def find_usuario_by_email!
    @user = Usuario.find_for_database_authentication(email: @params[:email])

    raise 'Usuário inexistente' unless @user.present?
  end
end
