class PostsController < ApplicationController
    # Adicionar constante para indicar quantos posts por página
    POSTS_PER_PAGE = 5

    before_action :set_post, only: [:show, :update, :destroy]

    # GET /posts posts da página
    def index
        # Define a página em que iremos buscar os posts
        @page = params.fetch(:page, 0).to_i

        # Para fazer a query /posts?page=nº_da_pagina
        
        # Busca os posts da pǵina, 5 posts por página, com os mais recentes primeiro
        @posts = Post.offset(@page*POSTS_PER_PAGE).limit(POSTS_PER_PAGE).reverse_order
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
