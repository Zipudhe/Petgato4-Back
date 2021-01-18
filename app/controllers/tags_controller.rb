class TagsController < ApplicationController
    TAGS_PER_PAGE = 5

    before_action :set_tag, only: [:show, :update, :destroy]
    before_action :all_tags, only: [:tags, :countags]

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

    # /alltags retorna todas as tags
    def tags
        render json: @tags, status: 200
    end

    # /countags retorna a quantidade de tags 
    def countags
        render json: @tags.size, status: 200
    end

    private

    def set_tag
        @tag = Tag.find(params[:id])
    end

    def tag_params
        params.require(:tag).permit(:name, :description)
    end

    # Salva todas as tags na variável global
    def all_tags
        @tags = Tag.all
    end

    def render_tags page
        # Renderiza 5 tags por página, @page = 0 é a primeira página
        @tags = Tag.offset((@page)*TAGS_PER_PAGE).limit(TAGS_PER_PAGE).reverse_order

        # Cria um array de hashes personalizado
        @tags_to_render = []
        for i in 0..(@tags.size - 1)
            n_posts = 0
            tag_id = @tags[i].id
            n_posts = TagPost.where(tag_id: tag_id).size
            hashref = {"id" => tag_id, "n_posts" => n_posts, "name" => @tags[i].name, 
            "description" => @tags[i].description}
            @tags_to_render.push(hashref)
        end
        render json: @tags_to_render, status: 200
    end

end
