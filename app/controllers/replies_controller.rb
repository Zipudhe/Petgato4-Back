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

    private

    def set_reply
        @reply = Reply.find(params[:id])
    end

    def reply_params
        params.require(:reply).permit(:description, :user_id, :comment_id)
    end

end
