class TagPostsController < ApplicationController
    before_action :set_tag_post, only: [:show, :update, :destroy]

    def index
        @tag_posts = TagPost.all
        render json:@tag_posts, status: 200
    end

    def show
        render json:@tag_post, status: 200
    end

    def create
        @tag_post = TagPost.new(tag_post_params)
        if @tag_post.save
            render json:@tag_post, status: 201
        else
            render json: @tag_post.errors, status: :unprocessable_entity
        end
    end

    def update
        if @tag_post.update(tag_post_params)
            render json: @tag_post, status: 200
        else
            render json: @tag_post.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @tag_post.destroy
    end

    # GET /tag_posts/tags/:id retorna as tags de um post
    def postags
        @posts = Post.where(id: params[:id])

        render json: @posts, status: 200
    end

    private

    def set_tag_post
        @tag_post = TagPost.find(params[:id])
    end

    def tag_post_params
        params.require(:tag_post).permit(:post_id, :tag_id)
    end

end
