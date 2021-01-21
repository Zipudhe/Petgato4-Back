class RepliesController < ApplicationController
    before_action :set_reply, only: [:show, :update, :destroy]

    def index
        @replies = Reply.all
        render json: @replies, status: 200
    end

    def show
        render json: @reply, status: 200
    end

    def create
        @reply = Reply.new(reply_params)
        if @reply.save
            render json: @reply, status: 201
        else
            render json: @reply.errors, status: :unprocessable_entity
        end
    end

    def update
        if @reply.update(reply_params)
            render json: @reply, status: 200
        else
            render json: @reply.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @reply.destroy
    end

    # /replies_by_comment/:comment_id Retorna todas as replies de um comment incluindo o usuário (nome e imagem) 
    def replies_by_comment
        replies = Reply.where(comment_id: params[:comment_id])

        # array que recebe os objetos
        @replies_to_render = []
        
        # Resgatar dados do usuário
        for i in 0..(replies.size-1)
            user = User.find(replies[i].user_id)
            hashref = {"comment_id" => replies[i].comment_id,
            "reply_id" => replies[i].id,
            "reply_description" => replies[i].description,
            "created_at" => replies[i].created_at,
            "author" => user.name,
            "is_admin" => user.is_admin
            #"author_img" => user.avatar ou user.image
            }
            @replies_to_render.push(hashref)
        end

        render json: @replies_to_render, status: 200
    end

    private

    def set_reply
        @reply = Reply.find(params[:id])
    end

    def reply_params
        params.require(:reply).permit(:description, :user_id, :comment_id)
    end

end
