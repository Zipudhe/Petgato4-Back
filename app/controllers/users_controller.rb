class UsersController < ApplicationController
    #before_action :authorize_request, only: [:update, :destroy]
    before_action :set_user, only: [:show, :update, :destroy]

    USERS_PER_PAGE = 5

    # GET /users all users
    def index
        @page = params.fetch(:page, 0).to_i

        render_users(@page)
    end 

    # GET /users/:id mostra info do user com id da rota 
    def show

        if @user.profile_image.attached?
            @url = url_for(@user.profile_image)

            @temp = {
                "url" => @url, 
                "id" => @user.id, 
                "name" => @user.name, 
                "email" => @user.email,
                "is_admin" => @user.is_admin,
                "created_at" => @user.created_at
            }

            render json: @temp, status: 200
        else
            render json: @user, status: 200
        end

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
            @url = url_for(@user.profile_image)

            render json: @user, status: 200
        else
            render json: @user.errors, status: 422
        end
    end

    # DELETE /users/:id
    def destroy
        @user.destroy

        @page = params.fetch(:page, 0).to_i
        render_users(@page)
    end

    def allusers
        render json: User.all, status: 200
    end

    def users_count
        render json: User.all.size, status: 200
    end

    private
    
    # Pegar id da rota e buscar o user correspondente no banco de dados
    def set_user
        @user = User.find(params[:id])
    end

    # Strong parameters, dizer quais parâmetros do BODY da requisição são permitidos 
    def user_params
        params.permit(:id, :name, :email, :password, :password_confirmation, :is_admin, :profile_image)
    end

    def render_users page
        @users = User.offset(@page*USERS_PER_PAGE).limit(USERS_PER_PAGE).reverse_order
        render json: @users, status: 200
    end

end
