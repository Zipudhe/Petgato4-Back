class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users all users
    def index
        @users = User.all
        render json:@users, status: 200
    end 

    # GET /users/:id mostra info do user com id da rota 
    def show
        render json:@user, status: 200
    end

    # POST /users criar um usuário
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: 201
        else
            render json: @user.errors, status: 422
        end
    end

    # PATCH/PUT /users/:id Atualizar os dados do user que vem do body da requisição
    def update
        if @user.update(user_params)
            render json: @user, status: 200
        else
            render json: @user.erros, status: 422
        end
    end

    # DELETE /users/:id
    def destroy
        @user.destroy
    end

    private
    
    # Pegar id da rota e buscar o user correspondente no banco de dados
    def set_user
        @user = User.find(params[:id])
    end

    # Strong parameters, dizer quais parâmetros do BODY da requisição são permitidos 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end

end
