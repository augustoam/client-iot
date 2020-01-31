class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_access_request!
  
  def reset_password
    resource = User.find_by_email(params['email'])
    unless resource.present?
      return render json: {
        code: 401,
        msg: 'Email inválido!'
      }, status: :unauthorized
    end
    resource.send_reset_password_instructions
    render json: { code: 200, user: resource.email }, status: :ok
  end

  def authenticate
    service = SessionAuthenticationService.new(user_authenticate_params).call

    render(service.success? ? service.server_payload : service.server_error)
  rescue StandardError => e
    render json: { code: 401, msg: e.message }, status: :unauthorized
  end

  def create
    if User.find_by(email: params[:email])
      return render json: {
        code: 409,
        msg: 'Este email já esta cadastrado!'
      }, status: :conflict
    end

    @user = User.new(user_create_params)
    unless @user.password_match?
      return render json: {
        code: 412,
        msg: 'Senhas não são iguais!'
      }, status: :precondition_failed
    end

    unless @user.valid?
      return render json: {
        code: 400,
        msg: 'Este usuário não é válido!'
      }, status: :bad_request
    end

    @user.save
    render json: {
      code: 201,
      msg: 'Verifique seu email para prosseguir com a confirmação da sua conta!',
      user: @user.email
    }, status: :created
  rescue StandardError => e
    render json: { code: 401, msg: e.message }, status: :error
  end

  private

  def user_authenticate_params
    {
      email: params[:email],
      password: params[:password]
    }
  end

  def user_create_params
    {
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    }
  end
end
