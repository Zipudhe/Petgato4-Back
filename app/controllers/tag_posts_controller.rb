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

    def add_remove
        temp = params[:tags].split(',')
        #temp[0].slice! "["
        #temp[temp.length-1].slice! "]"

        tags_array = []

        for i in 0..temp.length-1
            tags_array.push(temp[i].to_i)
        end

        post_tags = TagPost.where(post_id: params[:post_id])

        # Checar se é necessário criar novas tag_posts
        for i in 0..(tags_array.length - 1)
            is_included = false

            # verifica se já existe essa tag no banco de dados
            for j in 0..(post_tags.length - 1)
                if post_tags[j].tag_id == tags_array[i]
                    is_included = true
                    break
                end
            end

            if not is_included
                tag_post_temp = TagPost.new(post_id: params[:post_id].to_i, tag_id: tags_array[i])
                tag_post_temp.save
            end
        end

        # Checar se é necessário apagar alguma tag_post
        for i in 0..(post_tags.length - 1)
            is_included = false

            # verifica se já existe essa tag no array
            for j in 0..(tags_array.length - 1)
                if post_tags[i].tag_id == tags_array[j]
                    is_included = true
                    break
                end
            end

            if not is_included
                TagPost.find(post_tags[i].id).destroy
            end
        end
        
    end

    # GET /tag_posts/tags/:id retorna os posts de uma tag
    def postags
        @posts = TagPost.where(post_id: params[:id])

        render json: @posts, status: 200
    end

    # GET /countagposts/:tag_id retorna o número de posts em que a tag aparece
    def countagposts
        countposts = TagPost.where(tag_id: params[:tag_id])
        render json: countposts.size, status: 200
    end

    # GET /tagsbypost/:post_id retorna as tags de um post
    def tagsbypost
        tag_posts = TagPost.where(post_id: params[:post_id])
        tags = []
        for i in 0..(tag_posts.size - 1)
            tags.push(Tag.find(tag_posts[i].tag_id))
        end
        
        render json: tags, status: 200
    end

    # GET /postsbytag/:tag_id retorna os posts de uma tag
    def postsbytag
        tag_posts = TagPost.where(tag_id: params[:tag_id])
        posts = []
        for i in 0..(tag_posts.size - 1)
            posts.push(Post.find(tag_posts[i].post_id))
        end
        
        render json: posts, status: 200
    end

    private

    def set_tag_post
        @tag_post = TagPost.find(params[:id])
    end

    def tag_post_params
        params.require(:tag_post).permit(:post_id, :tag_id)
    end

end
