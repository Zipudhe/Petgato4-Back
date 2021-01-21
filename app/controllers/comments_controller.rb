class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]
    
    def index
        @comments = Comment.all
        render json:@comments, status: 200
    end

    def show
        render json:@comment, status: 200
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render json:@comment, status: 201
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def update
        if @comment.update(comment_params)
            render json: @comment, status: 200
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @comment.destroy
    end

    # /comments_by_post/:post_id Retorna todos os comments de um post incluindo o usuário (nome e imagem) 
    def comments_by_post
        comments = Comment.where(post_id: params[:post_id])

        # array que recebe os objetos
        @comments_to_render = []
        
        # Resgatar dados do usuário
        for i in 0..(comments.size-1)
            user = User.find(comments[i].user_id)
            hashref = {"post_id" => comments[i].post_id,
            "comment_id" => comments[i].id,
            "comment_description" => comments[i].description,
            "created_at" => comments[i].created_at,
            "author" => user.name
            #"author_img" => user.avatar ou user.image
            }
            @comments_to_render.push(hashref)
        end

        render json: @comments_to_render, status: 200
    end

    # GET /comments_count/:post_id Retorna o número de comentários (incluindo replies) de um post
    def count_comments
        count = 0
        comments = Comment.where(post_id: params[:post_id])
        count = comments.size
        # Resgatar número de replies de cada comment
        for i in 0..(comments.size - 1)
            count += Reply.where(comment_id: comments[i].id).size 
        end

        render json: {"n_comments" => count}, status: 200
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:description, :post_id, :user_id)
    end
end
