class PostsController < ApplicationController
    # Adicionar constante para indicar quantos posts por página
    POSTS_PER_PAGE = 5

    before_action :set_post, only: [:show, :update, :destroy]
    before_action :all_posts, only: [:posts, :countposts]

    # GET /posts posts da página
    def index
        # Define a página em que iremos buscar os posts
        @page = params.fetch(:page, 0).to_i

        # Para fazer a query /posts?page=nº_da_pagina
        
        # Busca os posts da pǵina, 5 posts por página, com os mais recentes primeiro
        render_posts(@page)
    end 

    # GET /posts/:id mostra info do post com id da rota 
    def show
        if @post.banner.attached?
            @url = url_for(@post.banner)

            @temp = {
                "url" => @url, 
                "id" => @post.id, 
                "name" => @post.name,
                "content" => @post.content,
                "views" => @post.views,
                "created_at" => @post.created_at
            }

            render json: @temp, status: 200
        else
            render json: @post, status: 200
        end
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
            @url = url_for(@post.banner)

            render json: @post, status: 200
        else
            render json: @post.erros, status: 422
        end
    end

    # DELETE /posts/:id
    def destroy
        @post.destroy

        @page = params.fetch(:page, 0).to_i
        render_posts(@page)
    end

    def posts
        render json: @posts, status: 200
    end

    def countposts
        render json: @posts.size, status: 200
    end

    # retorna os 3 posts mais populares (com mais visualizações)
    def popularposts
        @posts = Post.order(:views).last(3).reverse()

        render json: @posts, status: 200
    end

    # faz uma busca nos posts (text: valor a ser buscado)
    def search_posts
        @posts = Post.ransack(name_cont: params[:q]).result.limit(20)

        render json: @posts, status: 200
    end

    private

    # Pegar id da rota e buscar o post correspondente no banco de dados
    def set_post
        @post = Post.find(params[:id])
    end

    # Strong parameters, dizer quais parâmetros do BODY da requisição são permitidos 
    def post_params
        params.permit(:name, :content, :views, :banner)
    end

    def all_posts
        @posts = Post.all
    end

    # Busca os posts da página, 5 posts por página, com os mais recentes primeiro
    def render_posts page
        @posts = Post.offset(@page*POSTS_PER_PAGE).limit(POSTS_PER_PAGE).reverse_order

        # Pega nome das tags
        # No for utilizei posts.size pq pode ocorrer uma página com menos de 5 posts
        @posts_to_render = []
        for i in 0..(@posts.size - 1)
            @tagposts = TagPost.where(post_id: @posts[i].id)
            @tags = ""
            for j in 0..(@tagposts.size - 1)
                name = Tag.find(@tagposts[j].tag_id).name
                if j == (@tagposts.size - 1)
                    @tags += name
                else
                    @tags += name + ", "
                end
            end
            hashref = {"id" => @posts[i].id,
                "name" => @posts[i].name,
                "content" => @posts[i].content,
                "views" => @posts[i].views,
                "created_at" => @posts[i].created_at,
                "updated_at" => @posts[i].updated_at,
                "tags" => @tags
            }

            # verifica se existe imagem
            if @posts[i].banner.attached?
                @url = url_for(@posts[i].banner)
                hashref["url"] = @url
            end

            @posts_to_render.push(hashref)
        end

        render json:@posts_to_render, status: 200
    end

end
