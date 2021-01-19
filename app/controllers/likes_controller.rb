class LikesController < ApplicationController
    before_action :set_userlike, only: [:userliked, :destroy]
    before_action :set_postlike, only: [:postlikes]

    # GET /likes Mostra todos os likes
    def index
        @likes = Like.all
        render json: @likes, status: 200
    end

    # GET /likes/:user_id/:post_id Mostra se o usuário de like no post
    def userliked
        @liked = false
        if @like
            @liked = true
        end
        render json: @liked, status: 200
    end

    # DELETE /likes/:user_id/:post_id deletea like do usuário no post
    def destroy
        @like.destroy
        render json: {"message" => "Like deletado"}, status: 200
    end 

    # GET /likes/post/:post_id Mostra os likes no post com id especificada
    def postlikes
        render json: @likes.length, status: 200
    end

    # POST /likes Cria uma nova mensagem
    def create
        @like = Like.new(like_params)
        if @like.save
            render json: @like, status: 201
        else
            render json: @like.errors, status: 422
        end
    end

    private

    # Retorna os likes de um usuário 
    def set_userlike
        @like = Like.find_by(user_id: params[:user_id],  post_id: params[:post_id])
    end

    # Retorna os likes de uma postagem
    def set_postlike
        @likes = Like.where(post_id: params[:post_id])
    end
    
    def like_params
        params.require(:like).permit(:post_id, :user_id)
    end
end
