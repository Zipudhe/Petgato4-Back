class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :update, :destroy]

    REPORTS_PER_PAGE = 5

    def index
        @page = params.fetch(:page, 0).to_i
        render_reports(@page)
    end

    def show
        render json:@report, status: 200
    end
    
    def create
        @report = Report.new(report_params)
        if @report.save
            render json: @report, status: 201
        else
            render json: @report.errors, status: :unprocessable_entity
        end
    end

    def update
        if @report.update(report_params)
            render json: @report, status: 200
        else
            render json: @report.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @report.destroy

        @page = params.fetch(:page, 0).to_i
        render_reports(@page)
    end

    def allreports
        render json: Report.all, status: 200
    end

    def report_all_count
        render json: Report.all.size, status: 200
    end

    # retorna se uma report já existe no banco de dados
    def isreported
        @reported = false
        @temp_report = Report.where(comment_id: params[:comment_id], reply_id: params[:reply_id])

        if @temp_report.length > 0
            @reported = true
        end

        render json: @reported, status: 200
    end

    # retorna se uma report de comentário (reply_id = null) já existe no banco de dados
    def isreportedcomment
        @reported = false
        @temp_report = Report.where(comment_id: params[:comment_id])

        if @temp_report.length > 0
            @reported = true
        end

        render json: @reported, status: 200
    end

    private

    def set_report
        @report = Report.find(params[:id])
    end

    def report_params
        params.require(:report).permit(:reply_id, :comment_id)
    end

    def render_reports page
        @reports = Report.offset(@page*REPORTS_PER_PAGE).limit(REPORTS_PER_PAGE).reverse_order

        @reports_to_render = []
        for i in 0..(@reports.size - 1)
            @comment = Comment.find(@reports[i].comment_id)
            @post = Post.find(@comment.post_id)
            if @reports[i].reply_id == nil
                @user = User.find(@comment.user_id)
                hashref = {"tipo_report" => "comment",
                    "comment_id" => @comment.id,
                    "comment_description" => @comment.description,
                    "comment_author" => @user.name,
                    "post_id" => @post.id,
                    "post_name" => @post.name
                }
                @reports_to_render.push(hashref)
            else
                reply = Reply.find(@reports[i].reply_id)
                @user = User.find(reply.user_id)
                hashref = {"tipo_report" => "reply",
                    "reply_id" => reply.id,
                    "reply_description" => reply.description,
                    "reply_author" => @user.name,
                    "post_id" => @post.id,
                    "post_name" => @post.name
                }
                @reports_to_render.push(hashref)
            end
        end
        render json: @reports_to_render, status: 200
    end
end