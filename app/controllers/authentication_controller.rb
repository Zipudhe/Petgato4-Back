class AuthenticationController < ApplicationController
    before_action :authorize_request, only: []
  
    # POST /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       user_id: @user.id }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end

    # GET /is_token_valid Retorna se o token passado no header é válido ou não
    def is_token_valid
      authtoken = request.headers['Authorization']
      authtoken = authtoken.split(' ').last
      is_valid = JsonWebToken.valid_token(authtoken)

      render json: is_valid, status: 200
    end
    
    # GET /is_admin retorna se o id passado no header é valido ou não
    def is_admin
      user_id = request.headers['UserID']
      user_id = user_id.split(' ').last
      @user = User.find(user_id);

      render json: @user.is_admin, status: 200
    end

    private
  
    def login_params
      params.permit(:email, :password)
    end
  
  end