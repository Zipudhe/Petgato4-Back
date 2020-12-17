class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    # GET /posts all posts
    def index
        @posts = Post.all
        render json:@posts, status: 200
    end 

    # GET /posts/:id mostra info do post com id da rota 
    def show
        render json:@post, status: 200
    end

    # POST /posts criar um usuário
    def create
        @post = Post.new(post_params)
        if @post.save
            render json: @post, status: 201
        else
            render json: @post.errors, status: 422
        end
    end

    # PATCH/PUT /posts/:id Atualizar os dados do post que vem do body da requisição
    def update
        if @post.update(post_params)
            render json: @post, status: 200
        else
            render json: @post.erros, status: 422
        end
    end

    # DELETE /posts/:id
    def destroy
        @post.destroy
    end

    private

    # Pegar id da rota e buscar o post correspondente no banco de dados
    def set_post
        @post = Post.find(params[:id])
    end

    # Strong parameters, dizer quais parâmetros do BODY da requisição são permitidos 
    def post_params
        params.require(:post).permit(:name, :content, :image, :views)
    end

end
