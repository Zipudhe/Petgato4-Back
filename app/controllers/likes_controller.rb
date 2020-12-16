class LikesController < ApplicationController
    before_action :set_like, only: [:userlikes, :postlikes]

    # GET /likes Mostra todos os likes
    def index
        @likes = Like.all
        render json: @likes, status: 200
    end

    # GET /likes/:user_id Mostra os likes do usuário com id especificada
    def userlikes
        render json: @like, status: 200
    end

    # GET /likes/:post_id Mostra os likes no post com id especificada
    def postlikes
        render json: @like, status: 200
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

    def set_like
        @like = Like.find(params[:id])
    end

    def like_params
        params.require(:like).permit(:post_id, :user_id)
    end
end
