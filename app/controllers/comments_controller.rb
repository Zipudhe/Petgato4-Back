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

    # GET /comments/:post_id Retorna o número de comentários (incluindo replies) de um post
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
