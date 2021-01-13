class TagsController < ApplicationController
    TAGS_PER_PAGE = 5

    before_action :set_tag, only: [:show, :update, :destroy]

    def index
        @page = params.fetch(:page, 0).to_i

        render_tags(@page)
    end

    def show
        render json:@tag, status: 200
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            render json: @tag, status: 201
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

        @page = params.fetch(:page, 0).to_i
        render_tags(@page)
    end

    private

    def set_tag
        @tag = Tag.find(params[:id])
    end

    def tag_params
        params.require(:tag).permit(:name, :description)
    end

    def render_tags page
        @tags = Tag.offset((@page-1)*TAGS_PER_PAGE).limit(TAGS_PER_PAGE).reverse_order
        render json:@tags, status: 200
    end

end
