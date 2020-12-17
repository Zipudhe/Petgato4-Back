class LikesController < ApplicationController
    before_action :set_userlike, only: [:userlikes]
    before_action :set_postlike, only: [:postlikes]

    # GET /likes Mostra todos os likes
    def index
        @likes = Like.all
        render json: @likes, status: 200
    end

    # GET /likes//user/:user_id Mostra os likes do usuário com id especificada
    def userlikes
        render json: @likes, status: 200
    end

    # GET /likes/post/:post_id Mostra os likes no post com id especificada
    def postlikes
        render json: @likes, status: 200
    end

    # POST /likes Cria uma nova mensagem
    def create
        @like = Like.new(like_params)
        if @like.save
            render json: @like, status: 201
        else
            render json: @like.erros, status: 422
        end
    end

    private

    # Retorna os likes de um usuário 
    def set_userlike
        @likes = Like.where(user_id: params[:user_id])
    end

    # Retorna os likes de uma postagem
    def set_postlike
        @likes = Like.where(post_id: params[:post_id])
    end
    
    def like_params
        params.require(:like).permit(:post_id, :user_id)
    end
end
