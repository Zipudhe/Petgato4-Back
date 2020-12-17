class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :update, :destroy]

    def index
        @tags = Tag.all
        render json:@tags, status: 200
    end

    def show
        render json:@tag, status: 200
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            render json:@tag, status: 201
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
    end

    def update
        if @tag.update(tag_params)
            render json: @tag, status: 200
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @tag.destroy
    end

    private

    def set_tag
        @tag = Tag.find(params[:id])
    end

    def tag_params
        params.require(:tag).permit(:name, :description, :rating)
    end

end
